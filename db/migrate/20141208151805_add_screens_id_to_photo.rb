class AddScreensIdToPhoto < ActiveRecord::Migration
  def change
  	add_reference :photos, :screen, index: true
  end
end
