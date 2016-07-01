class CommentsController < ApplicationController
	def new
	  @comment = Comment.new
	end

    def index
      @comments = Comment.all	
    end

    def show
      @comment = Comment.find_by id: params[:id]
    end

	def create
    @comment = Comment.new comment_params
    @comment.entry_id = params[:entry_id]
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to entry_path(params[:entry_id])
    else
      render "entries/show"
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to @entry
    else
      render "entries/show"
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
