class CollaboratorsController < ApplicationController

  def new
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)

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
