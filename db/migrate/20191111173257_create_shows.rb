class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :show_name
      t.integer :episodes_watched
      t.integer :seasons_completed
    end
  end
end
