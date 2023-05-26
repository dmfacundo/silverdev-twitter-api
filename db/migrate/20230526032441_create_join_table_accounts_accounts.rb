class CreateJoinTableAccountsAccounts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :accounts, :friends do |t|
      t.index [:account_id, :friend_id], unique: true
    end
  end
end
