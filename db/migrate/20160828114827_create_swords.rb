class CreateSwords < ActiveRecord::Migration[5.0]
  def change
    create_table :swords do |t|
      t.string :name
      t.integer :damage

      t.timestamps
    end
  end
end
