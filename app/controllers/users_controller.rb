class UsersController < ApplicationController
  authorize_resource

  def show
    @user = User.find_by(username: params[:id].downcase)
  end
end
