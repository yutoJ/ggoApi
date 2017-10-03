class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :price, null: false
      t.integer :status, null: false, default: 0
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :user, foreign_key: true, null: false
      t.references :gadget, foreign_key: true, null: false

      t.timestamps
    end
  end
end
