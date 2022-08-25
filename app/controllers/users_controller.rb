class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    render(json: { errors: @user.errors }, status: :bad_request) unless @user.save
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      @access_token = access_token(@user)
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def access_token(user)
    iat = Time.now.to_i
    exp = Time.now.to_i + 60.day.to_i
    payload = {
      'sub': user.id,
      'iat': iat,
      'exp': exp
    }
    JWT.encode(payload, nil, 'none')
  end
end
