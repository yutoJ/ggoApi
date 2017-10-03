class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :gadget, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
