class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
      if @wiki.save
        flash[:notice] = "Wiki was saved successfully"
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error creating this wiki.  Please try again"
        render :new
      end
      authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "Successfully updated \"#{@wiki.title}\""
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating this wiki.  Please try again"
      render :edit
    end
    authorize @wiki

  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was successfully deleted"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting this wiki.  Try again"
      render :show
    end
    authorize @wiki
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user)
  end
end
