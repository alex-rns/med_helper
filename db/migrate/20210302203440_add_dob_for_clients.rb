class AddDobForClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :dob, :string
  end
end
