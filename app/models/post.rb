class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_one_attached :image
  has_many :post_ingredients, dependent: :destroy
  has_many :ingredients, through: :post_ingredients

  has_many :steps,-> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true

  accepts_nested_attributes_for :post_ingredients, allow_destroy: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  
  validates :title, presence: true
  validates :image, presence: true
end
