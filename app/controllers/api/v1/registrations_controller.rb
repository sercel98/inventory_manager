class Api::V1::RegistrationsController < Devise::RegistrationsController

  #Antes de ejecutarse verificar que los parámetros existan
  before_action :ensure_params_exist, only: :create
  #No validar el token cuando se esté registrando un usuario
  skip_before_action :verify_authenticity_token, raise: false,  :only => :create
  
  # sign up
  def create
    user = User.new user_params
    if user.save
      render json: {
        messages: "Sign Up Successfully",
        is_success: true,
        data: {user: user}
      }, status: :ok
    else
      render json: {
        messages: "Sign Up Failded",
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :encrypted_password, :first_name, :last_name)
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
      }, status: :bad_request
  end
end
