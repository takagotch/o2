class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.micorposts.paginate(page: params[:page])
  end

end

