class AccountsController < ApplicationController
  before_action :set_account, :check_permissions, only: [:show, :edit, :update, :destroy]
  before_action :set_carrier_param, only: [:create, :update]
  before_action :check_admin, only: [:index]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        current_user.update_attributes(account_id: @account.id)
        format.html { redirect_to root_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to root_path, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      begin
        @account = Account.find(params[:id])
      rescue
        redirect_to root_path, alert: "Couldn't find that account. Sorry."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:first_name, :last_name, :phone_number, :carrier)
    end

    def check_permissions
      unless current_user.account_id == @account.id || (current_user.camp_admin? && current_user.camp_id == @account.user.camp_id) || current_user.master_admin?
        redirect_to root_path, alert: "You don't have permission to access that page. Sorry."
      end
    end

    def check_admin
      unless current_user.master_admin?
        redirect_to root_path, alert: "You don't have permission to access that page. Sorry."
      end
    end

    def set_carrier_param
      params["account"]["carrier"] = params["account"]["carrier"].to_i unless params["account"]["carrier"] == ""
    end
end
