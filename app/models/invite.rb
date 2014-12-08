class Invite < ActiveRecord::Base
	belongs_to :project
	belongs_to :sender, :class_name => 'User'
	belongs_to :recipient, :class_name => 'User'

	before_create :generate_token, :invited
	before_save :check_user_existence

	def check_user_existence
		recipient = User.find_by_email(email)
		if recipient
			self.recipient_id = recipient.id
		end
	end

	def generate_token
		self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
	end
	
	def invited
		self.invited_at = Time.now.utc
	end

	def redeemed!
		self.redeemed_at = Time.now.utc
		self.save
	end
end
