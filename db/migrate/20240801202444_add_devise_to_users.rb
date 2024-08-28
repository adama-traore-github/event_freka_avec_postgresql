class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      unless column_exists?(:users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end
    end
  end
end
