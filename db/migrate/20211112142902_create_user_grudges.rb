class CreateUserGrudges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_grudges do |t|
      t.references :guilty, null: false, foreign_key: {to_table: :users}
      t.references :offended, null: false, foreign_key: {to_table: :users}
      t.references :grudge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
