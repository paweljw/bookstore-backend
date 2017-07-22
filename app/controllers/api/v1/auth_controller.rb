# frozen_string_literal: true

module Api
  module V1
    class AuthController
      def create
        auth_command = AuthenticateUserCommand.call(auth_params[:user], auth_params[:password])

        if command.call
      end

      private

      def auth_params
        params.require(:user, :password)
      end
    end
  end
end
