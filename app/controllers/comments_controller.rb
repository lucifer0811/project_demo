class CommentsController < ApplicationController
	def new
	  @comment = Comment.new
	end

    def index
      @comments = Comment.all	
    end

	def create
	  @entry = Entry.find(params[:entry_id])
      @comment = @entry.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to @entry
      else
        flash.now[:danger] = "error"
      end
	end

	def destroy
	  @entry = Entry.find(params[:entry_id])
      @comment = @entry.comments.find(params[:id])
      @comment.destroy
      redirect_to entry_path	
	end

	private 

	  def comment_params
	  	params.require(:comment).permit(:user_id, :content, :entry_id)
	  end
end
