class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      #t.belongs_to :user
      t.integer :user_id
      t.references :likable, :polymorphic=>true
      t.timestamps null: false
    end
  end
end
