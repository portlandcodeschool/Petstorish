class CreateOptionAssignments < ActiveRecord::Migration
  def change
    create_table :option_assignments do |t|
      t.integer :option_id
      t.integer :product_id

      t.timestamps
    end
  end
end
