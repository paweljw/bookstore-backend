# frozen_string_literal: true

class BaseCommand
  attr_reader :result

  def self.call(*args)
    new(*args).call
  end

  def call
    @result = nil
    payload
    self
  end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  # :nocov:
  def initialize(*_)
    raise NotImplementedError, 'Implement `initialize` for classes inheriting from BaseCommand'
  end

  def payload
    raise NotImplementedError, 'Implement `payload` for classes inheriting from BaseCommand'
  end
  # :nocov:
end
