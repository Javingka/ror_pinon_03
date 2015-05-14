class AddPrecioToMotos < ActiveRecord::Migration
  def change
    add_column :motos, :precio, :string
  end
end
