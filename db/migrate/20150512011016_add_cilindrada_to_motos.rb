class AddCilindradaToMotos < ActiveRecord::Migration
  def change
    add_column :motos, :cilindrada, :string
  end
end
