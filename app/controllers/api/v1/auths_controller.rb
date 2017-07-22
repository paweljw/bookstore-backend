# frozen_string_literal: true

module Api
  module V1
    class AuthsController < ApplicationController
      skip_before_action :authenticate_user

      def create
        token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)

        if token_command.success?
          render json: { token: token_command.result }
        else
          render json: { error: token_command.errors }, status: :unauthorized
        end
      end
    end
  end
end
