class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :add_worker, :remove_worker]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_worker
    @activity.users << current_user
    alert_camp_admin_of_activity("added")
    respond_to do |format|
      format.js { flash.now[:notice] = "Added you to the activity" }
    end
  end

  def remove_worker
    if params["user"].present?
      @activity.users.delete(User.find(params["user"]))
    else
      @activity.users.delete(current_user)
      alert_camp_admin_of_activity("removed")
    end
    respond_to do |format|
      format.js { flash.now[:notice] = "Removed you from the activity" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    #send emails if activity is deleted
    def alert_camp_admin_of_activity(method)
      WorkNotifierMailer.let_camp_admin_know(@activity, current_user, method).deliver!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:id, :name, :day, :start, :end_date, :end, :staff_needed, :guest_group_id, :activity_type, :_destroy)
    end
end
