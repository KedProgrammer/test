class AuthenticateAdmin<AuthenticateUser

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end
  private

  attr_reader :email, :password

  def user
    user = AdminUser.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end