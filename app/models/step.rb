class Step < ApplicationRecord
  belongs_to :post, optional: true
  has_one_attached :image
end
