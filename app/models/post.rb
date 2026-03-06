class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_one_attached :image
  has_many :post_ingredients, dependent: :destroy
  has_many :ingredients, through: :post_ingredients

  has_many :steps,-> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :post_ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank
  
  validates :title, presence: true
  validates :body, presence: true
  #validates :image, presence: true

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
