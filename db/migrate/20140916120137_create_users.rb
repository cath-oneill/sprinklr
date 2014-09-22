class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :provider
      t.string :address
      t.string :zip
      t.decimal :latitude
      t.decimal :longitude
      t.integer :contact_method
      t.string :email
      t.string :phone
      t.string :login_email
      t.string :profile_pic

      t.timestamps
    end
  end
end
