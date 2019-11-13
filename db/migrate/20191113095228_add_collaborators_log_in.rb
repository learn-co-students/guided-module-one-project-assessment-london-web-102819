class AddCollaboratorsLogIn < ActiveRecord::Migration[5.2]
  def change
    add_column :collaborators, :log_in_email, :string
    add_column :collaborators, :password, :string 
  end
end
