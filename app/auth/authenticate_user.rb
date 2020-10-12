# frozen_string_literal: true

class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user_id) if user
  end

  private

    def user
      user = User.find_by(email: @email)
      return user if user && user.authenticate(@password)

      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end
