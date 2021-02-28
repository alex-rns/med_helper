class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.references :user
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
