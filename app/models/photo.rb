class Photo < ActiveRecord::Base
	acts_as_commentable
	
	belongs_to :screen

	mount_uploader :image, PhotoUploader
end
