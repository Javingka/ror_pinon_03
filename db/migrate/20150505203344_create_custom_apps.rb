class CreateCustomApps < ActiveRecord::Migration
  def change
    create_table :custom_apps do |t|
      t.string :est_per_file
      t.string :est_lat_file
      t.string :est_sup_file
      t.string :apl_per_file
      t.string :apl_lat_file
      t.string :apl_sup_file
      t.string :asi_per_file
      t.string :asi_lat_file
      t.string :asi_sup_file
      t.string :man_per_file
      t.string :man_lat_file
      t.string :man_sup_file
      t.string :lla_per_file
      t.string :lla_lat_file
      t.string :lla_sup_file
      t.string :foc_per_file
      t.string :foc_lat_file
      t.string :foc_sup_file
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :custom_apps, [:user_id, :created_at]
  end
end
