class WikiPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @wiki = model
  end

  def update?
    @current_user.present?
  end

end
