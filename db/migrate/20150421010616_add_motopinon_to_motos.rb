class AddMotopinonToMotos < ActiveRecord::Migration
  def change
    add_column :motos, :motopinon, :boolean, default: false
  end
end
