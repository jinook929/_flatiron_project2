class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false # (except for the first user)
      t.boolean :super, default: false # (except for the first user)

      t.timestamps
    end
  end
end
