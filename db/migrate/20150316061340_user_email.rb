class UserEmail < ActiveRecord::Migration
  def change
    add_column :topics, :user_email, :string
    add_column :answers, :user_email, :string
  end
end
