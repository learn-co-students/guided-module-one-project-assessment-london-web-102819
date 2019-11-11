class CollaboratorsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :instrument
      t.string :instrumental_repertoire
      t.string :voice_type
      t.string :vocal_repertoire
    end
  end
end