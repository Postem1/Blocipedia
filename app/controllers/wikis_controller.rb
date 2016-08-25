class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
      if @wiki.save
        flash[:notice] = "Wiki was saved sucessfully"
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error creating this wiki.  Please try again"
        render :new
      end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    authorize @wiki

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
      flash[:notice] = "\"#{@wiki.title}\" was uccessfully deleted"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting this wiki.  Try again"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
