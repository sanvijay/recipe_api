class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      head :ok
    else
      render json: resource.errors, status: :bad_request
    end
  end

  private

  def sign_up_params
   params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
