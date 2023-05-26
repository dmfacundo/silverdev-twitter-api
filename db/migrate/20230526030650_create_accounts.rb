class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false, index: { unique: true }, limit: 50

      t.timestamps
    end
  end
end
