class AddAnoToMotos < ActiveRecord::Migration
  def change
    add_column :motos, :ano, :string
  end
end
