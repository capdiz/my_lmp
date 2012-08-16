class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string	  :first_name
      t.string 	  :last_name
      t.string    :address
      t.string    :country
      t.string    :city
      t.string	  :phone_number
      t.integer   :user_id

      t.timestamps
    end
    add_index :suppliers, :user_id 
  end

  def self.down
    drop_table :suppliers
  end
end
