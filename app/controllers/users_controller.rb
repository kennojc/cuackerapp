class UsersController < ApplicationController
  def index
    
    @users = User.all
    @last = User.last

  end
end

def show
  @user = User.find_by_id(params[:id])
end