class WikiPolicy
  attr_reader :current_user, :wiki

  def initialize(current_user, model)
    @current_user = current_user
    @wiki = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    current_user.present? && (wiki.private == false || wiki.user == current_user || current_user.admin?)
  end

  def destroy?
    current_user.admin?
  end

end
