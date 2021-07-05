class AppointmentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :pianist_id
      t.integer :collaborator_id
    end
  end
end