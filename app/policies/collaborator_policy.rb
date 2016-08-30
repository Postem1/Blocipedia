class CollaborationPolicy

  attr_reader :current_user, :collaborator

  def initialize(current_user, model)
    @current_user = current_user
    @collaborator = model
  end

  def new?
    user.present? && (user.admin? || user.premium?)
  end

  def create?
    user.present? && (user.admin? || user.premium?)
  end

  def destroy?
    current_user.present? && (wiki.user == current_user || current_user.admin?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = [] #is this needed?
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
