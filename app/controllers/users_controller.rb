class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.role = @user.role == 'user' ? "camp_admin" : "user"
    respond_to do |format|
      if @user.save!
        flash.now[:notice] = "#{@user.account.first_name} is now a #{@user.role.humanize.titleize}"
        format.js
      else
        flash.now[:alert] = "There was an error in updating this user"
        format.js 
      end
    end
  end

end