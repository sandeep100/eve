class Api::V1::RegistrationsController  < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    user = User.new(registration_params)


    if user.save
      render :json => user.as_json(:id=>user.id, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors.full_messages, :status=>422
    end
  end

  def registration_params
    params.require(:registration).permit(:email, :password)
  end

end