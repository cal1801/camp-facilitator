class GuestGroupsController < ApplicationController
  before_action :set_guest_group, only: [:show, :edit, :update, :destroy]

  # GET /guest_groups
  # GET /guest_groups.json
  #def index
    #@guest_groups = GuestGroup.all
  #end

  # GET /guest_groups/1
  # GET /guest_groups/1.json
  #def show
  #end

  # GET /guest_groups/new
  def new
    if current_user.camp_admin? || current_user.master_admin?
      @guest_group = GuestGroup.new
      @activities = [@guest_group.activities.build]
    else
      redirect_to root_path, alert: 'Not authorized to create a group'
    end
  end

  # GET /guest_groups/1/edit
  def edit
    @activities = @guest_group.activities
  end

  # POST /guest_groups
  # POST /guest_groups.json
  def create
    @guest_group = GuestGroup.new(guest_group_params)
    respond_to do |format|
      if @guest_group.save
        format.html { redirect_to root_path, notice: 'Guest group was successfully created.' }
        format.json { render :show, status: :created, location: @guest_group }
      else
        format.html { render :new }
        format.json { render json: @guest_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guest_groups/1
  # PATCH/PUT /guest_groups/1.json
  def update
    #send email update if any activities are Removed
    activities_to_remove = params["guest_group"]["activities_attributes"].select{|a, data| data["_destroy"] == "1"}
    alet_users_of_deleted_activites(activities_to_remove) unless activities_to_remove.empty?

    #remove any work assignments
    activities_to_remove.each do |i, act_param|
      Activity.find(act_param["id"].to_i).users.clear
    end

    respond_to do |format|
      if @guest_group.update(guest_group_params)
        format.html { redirect_to root_path, notice: 'Guest group was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest_group }
      else
        format.html { render :edit }
        format.json { render json: @guest_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guest_groups/1
  # DELETE /guest_groups/1.json
  def destroy
    #send email update if any activities are Removed
    alet_users_of_deleted_activites(@guest_group.activities)

    #remove any work assignments
    @guest_group.activities.each do |activity|
      activity.users.clear
    end

    if current_user.camp_admin? || current_user.master_admin?
      @guest_group.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Guest group was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, alert: 'Not authorized to delete a group'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest_group
      @guest_group = GuestGroup.find(params[:id])
    end

    #send emails if activity is deleted
    def alet_users_of_deleted_activites(deleted_activities)
      unless current_user.camp_admin?
        @guest_group.camp.accounts.each do |account|
          user = account.user
          ids = []
          if params["_method"] == "delete"
            ids = deleted_activities.map(&:id)
          else
            deleted_activities.each{|i, data| ids << data["id"].to_i}
          end
          working_deleted_activities = user.activities.where(id: ids)
          unless working_deleted_activities.empty?
            WorkNotifierMailer.activities_deleted(account, working_deleted_activities, @guest_group.name).deliver!
          end
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_group_params
      params.require(:guest_group).permit(:name, :description, :arrives, :leaves, :camp_id, activities_attributes: [:id, :name, :day, :start, :end, :staff_needed, :_destroy])
    end
end
