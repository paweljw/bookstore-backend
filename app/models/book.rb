# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  monetize :price_cents

  validates :title, presence: true, uniqueness: true

  def to_s
    title
  end

  def as_json(options = {})
    options.reverse_merge!(include: :author)
    super(options)
  end
end
