class CreateMotos < ActiveRecord::Migration
  def change
    create_table :motos do |t|
      t.string :modelo
      t.string :name
      t.string :picture
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
