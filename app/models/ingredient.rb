class Ingredient < ApplicationRecord
  #belongs_to :post
  has_many :post_ingredients, dependent: :destroy
  has_many :posts, through: :post_ingredients

  validates :name, presence: true, uniqueness: true
end