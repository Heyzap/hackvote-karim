class AddActiveToHackday < ActiveRecord::Migration
  def change
    add_column :hackdays, :active, :boolean, :default => true
  end
end
