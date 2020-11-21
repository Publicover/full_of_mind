class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  private

    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
end
