class PianistsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pianists do |t|
      t.string :name
      t.integer :years_of_experience
      t.string :expertise
    end
  end
end