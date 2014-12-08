class Screen < ActiveRecord::Base
	has_many :photos, dependent: :destroy
	belongs_to :project

	accepts_nested_attributes_for :photos

	def recent_photo
		self.photos.last
	end
end
