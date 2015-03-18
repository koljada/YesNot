class Topic < ActiveRecord::Base
  has_many :answers
  has_many :likes, as: :likable
  validates :content, presence: true
  belongs_to(:user)

  def user
    super || User.new(username: "Deleted" )
  end
end
