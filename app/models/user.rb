class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :likes
  has_many :topics
  has_many :answers
  validates :username, presence: true

  def like object
    Like.create(user: self, likable: object)
  end

  def dislike object
    Like.where(user: self, likable: object).destroy_all
  end

  def like? object
    Like.where(user: self, likable:object).present?
  end

  def change_like object
    if self.like? object
      self.dislike object
    else
      self.like object
    end
  end

  def rate
    topic_likes = self.topics.pluck(:like_counter).inject(:+)||0
    answer_likes = self.answers.pluck(:like_counter).inject(:+)||0
    answer_likes+topic_likes
  end

end
