class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :votes, :index => true
      t.string :creators
      t.references :hackday, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
