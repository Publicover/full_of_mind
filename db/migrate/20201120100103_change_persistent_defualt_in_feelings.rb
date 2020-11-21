class ChangePersistentDefualtInFeelings < ActiveRecord::Migration[6.0]
  def up
    change_column :feelings, :persistent, :integer, default: 1
  end
  def down
    change_column :feelings, :persistent, :integer, default: nil
  end
end
