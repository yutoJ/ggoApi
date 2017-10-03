class CreateGadgets < ActiveRecord::Migration[5.0]
  def change
    create_table :gadgets do |t|
      t.string :gadget_type
      t.references :user, foreign_key: true, null: false
      t.text :description
      t.integer :price
      t.string :address
      t.boolean :active, default: false
      t.integer :instant, default: 1
      t.string :listing_name

      t.timestamps
    end
  end
end
