class AddRequirementsToGadget < ActiveRecord::Migration[5.0]
  def change
    add_column :gadgets, :require_mobile, :string
    add_column :gadgets, :require_account, :string
  end
end
