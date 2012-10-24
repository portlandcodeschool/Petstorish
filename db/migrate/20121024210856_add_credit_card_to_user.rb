class AddCreditCardToUser < ActiveRecord::Migration
  def change
    add_column :users, :credit_card, :string
    add_column :users, :address, :string
  end
end
