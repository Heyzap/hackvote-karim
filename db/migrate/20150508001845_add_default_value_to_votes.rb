class AddDefaultValueToVotes < ActiveRecord::Migration
  def change
    change_column_default :projects, :votes, 0
  end
end
