class ChangePageOrderDefaultInFeelings < ActiveRecord::Migration[6.0]
  def change
    change_column_default :feelings, :page_order, from: nil, to: 4
  end
end
