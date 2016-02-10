class ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user_from_token!

  respond_to :json

  ## 
  # User Authentication
  # Authenticates the user with OAuth2 Resource Owner Password Credentials Grant
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']
    auth_token ? authenticate_with_auth_token(auth_token) : authentication_error
  end

  private

  def authenticate_with_auth_token(auth_token)
    return authentication_error unless auth_token.include?(':')

    user_id = auth_token.split(':').first
    user    = User.find(user_id)

    if user && Devise.secure_compare(user.access_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authentication_error
    end
  end

  ## 
  # Authentication Failure
  # Renders a 401 error
  def authentication_error
    # User's token is either invalid or not in the right format
    render json: {error: t('application_controller.unauthorized')}, status: 401  # Authentication timeout
  end
end

