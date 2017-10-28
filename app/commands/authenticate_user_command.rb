# frozen_string_literal: true

class AuthenticateUserCommand < BaseCommand
  private

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user && user.authenticate(password)
  end

  def payload
    if password_valid?
      @result = JwtService.encode(contents)
    else
      errors.add(:base, I18n.t('authenticate_user_command.invalid_credentials'))
    end
  end

  def contents
    {
      user_id: user.id,
      email: user.email,
      admin: user.admin,
      exp: 24.hours.from_now.to_i
    }
  end
end
