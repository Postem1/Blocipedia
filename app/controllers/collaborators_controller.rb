class CollaboratorsController < ApplicationController

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new

    unless (@wiki.private == true && current_user == @wiki.user) || current_user.admin?
      flash[:alert] = "You are not currently allowed to perform this action"
      redirect_to root_path
    end
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)

    unless (@wiki.private == true && current_user == @wiki.user) || current_user.admin?
      flash[:alert] = "You are not currently allowed to perform this action."
      redirect_to root_path
    end

    if @collaborator.save
        flash[:notice] = "Successfully created/added to collaboratorating team"
        redirect_to @wiki
      else
        flash[:alert] = "There was an error adding collaborator.  Please try again"
        redirect_to @wiki
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    unless current_user.id == @wiki.user.id || current_user.admin?
      flash[:alert] = "You are not currently allowed to perform this action."
      redirect_to root_path
    end
    if @collaborator.destroy
      flash[:notice] = " #{@collaborator.user.email}  was removed from this wiki."
      redirect_to :back
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
