class GuestGroupsController < ApplicationController
  before_action :set_guest_group, only: [:show, :edit, :update, :destroy]

  # GET /guest_groups
  # GET /guest_groups.json
  def index
    @guest_groups = GuestGroup.all
  end

  # GET /guest_groups/1
  # GET /guest_groups/1.json
  def show
  end

  # GET /guest_groups/new
  def new
    @guest_group = GuestGroup.new
    @activity = @guest_group.activities.build
  end

  # GET /guest_groups/1/edit
  def edit
  end

  # POST /guest_groups
  # POST /guest_groups.json
  def create
    @guest_group = GuestGroup.new(guest_group_params)
    binding.pry
    respond_to do |format|
      if @guest_group.save
        format.html { redirect_to @guest_group, notice: 'Guest group was successfully created.' }
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
    binding.pry
    respond_to do |format|
      if @guest_group.update(guest_group_params)
        format.html { redirect_to @guest_group, notice: 'Guest group was successfully updated.' }
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
    @guest_group.destroy
    respond_to do |format|
      format.html { redirect_to guest_groups_url, notice: 'Guest group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest_group
      @guest_group = GuestGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_group_params
      params.require(:guest_group).permit(:name, :description, :arrives, :leaves, :camp_id, activities_attributes: [:id, :name, :day, :start, :end, :staff_needed])
    end
end
