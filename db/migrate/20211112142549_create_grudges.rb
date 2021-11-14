class CreateGrudges < ActiveRecord::Migration[6.1]
  def change
    create_table :grudges do |t|
      t.string :name
      t.integer :points
      t.string :category

      t.timestamps
    end
  end
end
