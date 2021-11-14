class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user1, null: false, foreign_key: {to_table: :users}
      t.references :user2, null: false, foreign_key: {to_table: :users}
      t.string :relation

      t.timestamps
    end
  end
end
