class IdeasController < ApplicationController
before_filter :validate_user, :only => [:edit, :destroy]
  def validate_user
    if current_user.id != Idea.find(params[:id]).user_id
        flash[:error] = "You're only allowed to edit/destroy your own ideas"
        redirect_to(:back)
    end
end

  def index
    @ideas = Idea.all
    @bideas = true
    render 'index'
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = @idea.comments.build
    render 'show'
  end

  def new
    @idea = Idea.new
    render 'new'
  end

  def edit
    @idea = Idea.find(params[:id])
    render 'edit'
  end

  def create
    if user_signed_in?
    @idea = Idea.new(idea_params)
    @idea.user_id=current_user.id
      if @idea.save
        
        redirect_to @idea, notice: 'Idea was successfully created.'
      else
        render action: 'new'
      end
       else
        flash[:error] = "You have to be logged in to create ideas"
       end
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'Idea was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_url, notice: 'Idea was successfully destroyed.'
  end

  private
  # Only allow a trusted parameter "white list" through.
  def idea_params
    params.require(:idea).permit(:name, :description, :picture, :status)
  end

end


