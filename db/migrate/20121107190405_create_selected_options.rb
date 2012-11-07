class CreateSelectedOptions < ActiveRecord::Migration
  def change
    create_table :selected_options do |t|
      t.integer :line_item_id
      t.integer :option_id

      t.timestamps
    end
  end
end
