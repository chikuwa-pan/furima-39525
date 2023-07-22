class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.new
    render :new
  end
end
