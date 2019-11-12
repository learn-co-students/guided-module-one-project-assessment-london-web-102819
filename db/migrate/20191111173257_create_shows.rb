class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :shows_name
      t.integer :episodes
      t.integer :seasons
    end
  end
end
