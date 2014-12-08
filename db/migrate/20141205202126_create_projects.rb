class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      
      t.timestamps
    end

    add_reference :projects, :user, index: true
  end
end
