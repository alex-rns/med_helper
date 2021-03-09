class AddImageToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :image, :string
  end
end
