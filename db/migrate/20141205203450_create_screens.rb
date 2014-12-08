class CreateScreens < ActiveRecord::Migration
  def change
    create_table :screens do |t|
      t.string :title
      t.text :description
      t.boolean :approved

      t.timestamps
    end
  end
end
