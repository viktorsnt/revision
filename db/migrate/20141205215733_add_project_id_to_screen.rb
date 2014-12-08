class AddProjectIdToScreen < ActiveRecord::Migration
  def change
    add_reference :screens, :project, index: true
  end
end
