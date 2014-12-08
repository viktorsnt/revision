class User < ActiveRecord::Base
  include Clearance::User

  has_many :collaborations
  has_many :projects, through: :collaborations
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'
end
