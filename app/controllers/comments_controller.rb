class CommentsController < ApplicationController
	def new
		@entry = Entry.find params[:entry_id]
		@comment = Comment.new
	end

	def create
		@entry = Entry.find params[:entry_id]
		@comment = Comment.new(comment_params)
	end

	private 

	  def comment_params
	  	params.require(:comment).permit(:comment, :params, :entry_id)
	  end
end
