class ApplicationController < ActionController::API
  before_action :authenticate_user

  helper_method :current_user
  attr_reader :current_user

  private
  
  def authenticate_user
    header = request.headers.fetch('Authorization', '').split(' ')
    if header[0] == 'Bearer'
      payload = JWT.decode(header[1], nil, false)[0]
      id = payload['sub']
      @current_user = User.find_by_id!(id)
    else
      head :unauthorized
    end
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    head :unauthorized
  end

end
