class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    render(json: { errors: @user.errors }, status: :bad_request) unless @user.save
  end

  private

  def user_params
    params.permit(:email, :name, :bio)
  end
end
