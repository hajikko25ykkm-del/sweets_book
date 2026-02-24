class Ingredient < ApplicationRecord
  has_many :post_ingredients, dependent: :destroy
  has_many :posts, through: :post_ingredients

  validates :name, presence: true, uniqueness: true
  #belongs_to :post
end
