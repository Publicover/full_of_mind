class AddPeresistentAndPageOrderToFeelings < ActiveRecord::Migration[6.0]
  def change
    add_column :feelings, :persistent, :integer, default: 0
    add_column :feelings, :page_order, :integer
  end
end
