class AddOrderToStep < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :order, :integer
  end
end
