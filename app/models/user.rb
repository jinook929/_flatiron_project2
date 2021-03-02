class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :countries, through: :posts, source: :country
  has_many :commented_posts, through: :comments, source: :post

  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
end
