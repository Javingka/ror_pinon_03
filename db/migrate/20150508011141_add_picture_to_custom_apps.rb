class AddPictureToCustomApps < ActiveRecord::Migration
  def change
    add_column :custom_apps, :picture, :string
  end
end
