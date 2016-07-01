class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @entries =  Entry.paginate(page: params[:page])
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = @entry.comments.new
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      redirect_to @entry
      # Handle a successful update
    else
      render :show
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def destroy
    @entry.destroy
    flash[:success] = "entry deleted"
    redirect_to request.referrer || root_url

  end

  private

    def entry_params
      params.require(:entry).permit(:title, :content, :user_id)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
