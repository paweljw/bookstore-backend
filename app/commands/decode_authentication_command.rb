# frozen_string_literal: true

class DecodeAuthenticationCommand < BaseCommand
  private

  attr_reader :headers

  def initialize(headers)
    @headers = headers
    @user = nil
  end

  def payload
    return unless token_present?
    @result = user if user && token_not_expired?
  end

  def user
    @user ||= User.find_by(id: decoded_id)
    @user || errors.add(:token, I18n.t('decode_authentication_command.token_invalid')) && nil
  end

  def token_not_expired?
    decoded_expiration_timestamp >= Time.now.to_i ||
      errors.add(:token, I18n.t('decode_authentication_command.token_expired')) && nil
  end

  def token_present?
    token.present?
  end

  def token
    return authorization_header.split(' ').last if authorization_header.present?
    errors.add(:token, 'Missing token')
    nil
  end

  def authorization_header
    headers['Authorization']
  end

  def token_contents
    @token_contents ||= JwtService.decode(token)
  end

  def decoded_id
    token_contents['user_id']
  end

  def decoded_expiration_timestamp
    token_contents['expiration'] || 0
  end
end
