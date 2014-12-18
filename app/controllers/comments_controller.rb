class CommentsController < ApplicationController
	# POST
	def add_comment
		commentable_type = comment_params[:commentable_type]
		commentable_id = comment_params[:commentable_id]
		# Get the object that you want to comment
		commentable = Comment.find_commentable(commentable_type, commentable_id)

		# Create a comment with the user submitted content
		comment = Comment.new(comment_params)
		# Assign this comment to the logged in user
		comment.user_id = current_user.id

		# Add the comment
		commentable.comments << comment

		redirect_to :back
		# redirect_to :action => commentable_type.downcase,
		# 	:id => commentable_id
	end

	private

	def comment_params
		params.require(:comment).permit(:title, :comment, :commentable_type, :commentable_id)
	end
end