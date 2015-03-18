class Answer < ActiveRecord::Base
  belongs_to :topic
  has_many :likes, as: :likable
  validates :content, presence: true
  belongs_to :user
  def user
    super || User.new(username: "Deleted" )
  end
end
