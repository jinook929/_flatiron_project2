class Post < ActiveRecord::Base
  belongs_to :user  
  belongs_to :country
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  validates :title, presence: true
  validates :content, presence: true
  validates :youtube, presence: true
end