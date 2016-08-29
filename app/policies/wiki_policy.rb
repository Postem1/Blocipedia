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
    current_user.present?
  end

  def create?
    current_user.present?
  end

  def edit?
    current_user.present? && (wiki.private == false || wiki.user == current_user || current_user.admin?)
  end

  def update?
    current_user.present? && (wiki.private == false || wiki.user == current_user || current_user.admin?)
  end

  def destroy?
    current_user.present? && (wiki.private == false || wiki.user == current_user || current_user.admin?)
  end

end
