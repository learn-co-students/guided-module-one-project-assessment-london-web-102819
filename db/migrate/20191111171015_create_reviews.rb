class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :show_id
      t.string :title
      t.integer :rating
      t.string :review_text
    end
  end
end
