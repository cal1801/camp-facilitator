class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]
  before_action :check_master_admin, only: [:create, :new, :destroy]
  before_action :check_camp_admin, only: [:edit, :update]

  # GET /camps
  # GET /camps.json
  def index
    @camps = Camp.all
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
  end

  # GET /camps/new
  def new
    @camp = Camp.new
  end

  # GET /camps/1/edit
  def edit
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to camps_url, notice: 'Camp was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  def send_invite
    respond_to do |format|
      if User.invite!(:email => params[:invite_email], camp_id: current_user.camp_id)
        format.js { flash.now[:notice] = "Invite Email Sent" }
      else
        format.js { flash.now[:alert] = "There has been an error, please try again" }
      end
    end
  end

  def remove_account_from_camp
    if params["account"].present?
      @account = Account.find(params["account"])
      user = @account.user
    else
      user = User.find(params["user"])
    end

    user.activities.clear
    respond_to do |format|
      if user.delete
        format.js { flash.now[:notice] = "Removed #{defined?(@account) ? @account.full_name : user.email} from camp's staff list" }
      else
        format.js { flash.now[:alert] = "There has been an error, please try again" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_params
      params.require(:camp).permit(:name, :website, :phone_number)
    end

    def check_master_admin
      unless current_user.master_admin?
        redirect_to root_path, alert: 'Not allowed to perform this function'
      end
    end

    def check_camp_admin
      unless (current_user.master_admin? || current_user.camp_admin?) && current_user.camp_id == @camp.id
        redirect_to root_path, alert: 'Not allowed to perform this function'
      end
    end
end
