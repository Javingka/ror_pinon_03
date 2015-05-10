class AddModeloToCustomApps < ActiveRecord::Migration
  def change
    add_column :custom_apps, :modelo, :string
  end
end
