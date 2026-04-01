class Post < ApplicationRecord
  # --- 1. アソシエーション ---
  belongs_to :user
  belongs_to :genre, optional: true
  
  has_one_attached :image
  
  has_many :post_ingredients, dependent: :destroy
  has_many :ingredients, through: :post_ingredients
  has_many :steps, -> { order(position: :asc) }, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  # --- 2. ネストした属性の設定 ---
  accepts_nested_attributes_for :post_ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, 
    reject_if: proc { |attributes| attributes['content'].blank? && !attributes['image'].present? }

  # --- 3. バリデーション ---
  validates :image, presence: true
  validates :title, presence: true
  validates :genre, presence: true 
  validates :body, presence: true

  # --- 4. インスタンスメソッド ---
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  scope :viewable_by, ->(user) {
    if user.present?
      where("posts.user_id = ? OR posts.is_public = ?", user.id, true)
    else
      where(is_public: true)
    end
}
end