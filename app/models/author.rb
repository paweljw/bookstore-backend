class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true

  def to_s
    name
  end
end
