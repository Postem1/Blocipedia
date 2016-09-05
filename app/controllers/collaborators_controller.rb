class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id)
    authorize @collaborator
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    authorize @collaborator
    if @collaborator.save
      flash[:notice] = "#{@collaborator.wiki.user.email}  was added to this wiki."
      redirect_to @wiki
    else
      flash[:alert] = "Collaborator was not added. Please try again."
      redirect_to root_path
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    authorize @collaborator
    if @collaborator.destroy
      flash[:notice] = "#{@collaborator.user.email} was removed from this wiki."
      redirect_to @wiki
    else
      flash[:alert] = "Collaborator was not removed. Please try again."
      redirect_to root_path
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
