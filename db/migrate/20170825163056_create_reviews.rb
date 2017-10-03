class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 1
      t.references :gadget, foreign_key: true
      t.references :reservation, foreign_key: true
      t.integer :owner_id, null: false
      t.integer :guest_id, null: false
      t.string :type

      t.timestamps
    end
  end
end
