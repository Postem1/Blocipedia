class WikiPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @wiki = model
  end

  def update?
    @current_user.present?
    @wiki.private == false || @wiki.user == @current_user || @current_user.admin? 
  end

  def destroy?
    @current_user.admin?
  end

end
