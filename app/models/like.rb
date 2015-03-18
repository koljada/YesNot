class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, polymorphic: true
  after_create :update_like_counter
  after_destroy :decrease_like_counter

  def update_like_counter
    self.likable.like_counter+=1
    self.likable.save
  end

  def decrease_like_counter
    self.likable.like_counter-=1
    self.likable.save
  end
end
