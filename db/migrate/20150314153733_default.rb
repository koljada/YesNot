class Default < ActiveRecord::Migration
  def change
    change_column :topics, :user_id, :integer,default: 1
  end
end
