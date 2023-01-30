class User < ApplicationRecord
  belongs_to :subject
  validates :subject_id, presence: true
  belongs_to :club
  validates :club_id, presence: true
  belongs_to :kinds_of_school
  validates :kinds_of_school_id, presence: true

  has_many :active_relationships,   class_name:   "Relationship",
                                    foreign_key:  "follower_id",
                                    dependent:    :destroy
  has_many :passive_relationships,  class_name:   "Relationship",
                                    foreign_key:  "followed_id",
                                    dependent:    :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :subject_posts, dependent: :destroy
  has_many :club_posts, dependent: :destroy
  has_many :kinds_of_school_posts, dependent: :destroy
  has_many :private_groups, dependent: :destroy
  has_many :private_group_posts, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :joining, through: :participations, source: :private_group
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end
  has_many :publishers
  has_many :reference_books
  has_many :worksheets
  has_many :book_favorites, dependent: :destroy
  has_many :favorite_books, through: :book_favorites, source: :reference_book
  has_many :worksheet_favorites, dependent: :destroy
  has_many :favorite_worksheets, through: :worksheet_favorites, source: :worksheet

  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 140 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :image,    content_type:  { in: %w[image/jpeg image/gif image/png],
                                        message: "形式は「jpeg / gif / png」のいずれかにしてください" },
                       size:          { less_than: 5.megabytes,
                                        message: "画像は5MB以下にしてください"}

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # 現在のユーザーが他のユーザーをフォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # グループに参加する
  def join(private_group)
    joining << private_group
  end

  # グループから抜ける
  def leave(private_group)
    joining.delete(private_group) unless self == private_group.user
  end

  # 現在のユーザーがグループに参加していればtrueを返す
  def joining?(private_group)
    joining.include?(private_group)
  end

  # 書籍をお気に入りする
  def favorite_book(book)
    likes_count = book.likes_count + 1
    book.update!(likes_count: likes_count)
    favorite_books << book
  end

  # 書籍のお気に入りを解除する
  def unfavorite_book(book)
    likes_count = book.likes_count - 1
    book.update!(likes_count: likes_count)
    favorite_books.delete(book)
  end

  # 現在のユーザーが書籍をお気に入りしていればtrueを返す
  def favorite_book?(book)
    favorite_books.include?(book)
  end

  # ワークシートをお気に入りする
  def favorite_worksheet(worksheet)
    likes_count = worksheet.likes_count + 1
    worksheet.update!(likes_count: likes_count)
    favorite_worksheets << worksheet
  end

  # ワークシートのお気に入りを解除する
  def unfavorite_worksheet(worksheet)
    likes_count = worksheet.likes_count - 1
    worksheet.update!(likes_count: likes_count)
    favorite_worksheets.delete(worksheet)
  end

  # 現在のユーザーがワークシートをお気に入りしていればtrueを返す
  def favorite_worksheet?(worksheet)
    favorite_worksheets.include?(worksheet)
  end

end
