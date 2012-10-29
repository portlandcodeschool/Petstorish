class RenameClassToFamily < ActiveRecord::Migration
  def change
    rename_column :options, :class, :family
  end
end
