class RemoveUserIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :email
    remove_index :users, :username
  end
end
