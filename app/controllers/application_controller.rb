# frozen_string_literal: true

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include AdminAuthorizable
end
