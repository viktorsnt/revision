class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :project_id
      t.integer :sender_id
      t.integer :recipient_id
      t.string :token
      t.datetime :invited_at
      t.datetime :redeemed_at

      t.timestamps
    end
  end
end
