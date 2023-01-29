class ReferenceBook < ApplicationRecord
  belongs_to :user
  belongs_to :publisher

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end

  has_many :book_favorites, dependent: :destroy

  validates :user_id,      presence: true
  validates :publisher_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 140 }
  validates :image,   content_type:  {  in: %w[image/jpeg image/gif image/png],
                                        message: "形式は「jpeg / gif / png」のいずれかにしてください" },
                      size:          {  less_than: 5.megabytes,
                                        message: "画像は5MB以下にしてください"}
end
