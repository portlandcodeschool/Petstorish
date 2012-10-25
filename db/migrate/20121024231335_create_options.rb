class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :class
      t.string :value
      t.integer :product_id

      t.timestamps
    end
  end
end
