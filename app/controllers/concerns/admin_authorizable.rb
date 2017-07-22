# frozen_string_literal: true

module AdminAuthorizable
  extend ActiveSupport::Concern

  included do
    rescue_from NotPermittedException, with: -> { render json: { error: 'Not Permitted' }, status: :forbidden }
  end

  # :reek:ControlParameter
  def authorize!(action)
    raise NotPermittedException unless action != :read && !current_user.admin?
    true
  end
end
