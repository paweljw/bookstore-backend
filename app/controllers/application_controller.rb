# frozen_string_literal: true

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include AdminAuthorizable

  rescue_from ActiveRecord::RecordNotFound, with: -> { render json: { error: 'Not found' }, status: :not_found }
end
