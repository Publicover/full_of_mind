# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    # byebug
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token, user: User.find_by(email: auth_params[:email]))
  end

  private

    def auth_params
      params.permit(:email, :password)
    end
end
