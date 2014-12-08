class InvitationMailer < ActionMailer::Base
	default from: ENV["INVITATION_EMAIL"]

	def existing_user_invite(invite)
		@project = invite.project
		@sender = invite.sender
		@recipient = invite.recipient
		@url  = "http://localhost:3000/projects/#{invite.project_id}"
		mail(to: @recipient.email, subject: 'Convidado para novo projeto')
	end

	def deliver_invitation(invite, url)
		@project = invite.project
		@sender = invite.sender
		@url = url
		mail(to: invite.email, subject: 'Welcome to My Awesome Site', track_opens: 'true')
	end

	def deliver_confirmation(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end
end
