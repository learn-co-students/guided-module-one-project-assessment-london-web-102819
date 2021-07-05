class AddPianistLogIn < ActiveRecord::Migration[5.2]
  def change
    add_column :pianists, :log_in_email, :string
    add_column :pianists, :password, :string 
  end
end
