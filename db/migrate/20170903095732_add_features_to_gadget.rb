class AddFeaturesToGadget < ActiveRecord::Migration[5.0]
  def change
    add_column :gadgets, :has_guarantee, :boolean
    add_column :gadgets, :has_manual, :boolean
    add_column :gadgets, :has_content, :boolean
    add_column :gadgets, :has_no_setup, :boolean
    add_column :gadgets, :has_battery, :boolean
  end
end
