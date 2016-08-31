class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    unless @wiki.private == false || current_user.id == @wiki.user_id || current_user.admin? || @wiki.collaborators.include?(current_user)
      flash[:alert] = "You are not currently allowed to view this private wiki."
      redirect_to root_path
    end
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
      if @wiki.save
        flash[:notice] = "Wiki was saved successfully"
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error creating this wiki.  Please try again"
        render :new
      end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "Successfully updated \"#{@wiki.title}\""
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating this wiki.  Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was successfully deleted"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting this wiki.  Try again"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
