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
    
    if @collaborator.destroy
      flash[:notice] = " #{@collaborator.user.email}  was removed from this wiki."
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
