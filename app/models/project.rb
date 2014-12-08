class Project < ActiveRecord::Base
	has_many :screens, dependent: :destroy
	has_many :collaborations
	has_many :users, through: :collaborations
	has_many :invites

	def owner
		self.user_id
	end
	def collaborators
		self.users
	end
end
