class Book < ApplicationRecord
  belongs_to :author
  monetize :price_cents
end
