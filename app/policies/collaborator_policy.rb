 class CollaboratorPolicy

   attr_reader :current_user, :collaborator

   def initialize(current_user, model)
     @current_user = current_user
     @collaborator = model
   end

   def new?
      current_user.present? && (current_user.admin? || current_user.premium? )
   end

   def create?
     current_user.present? && (current_user.admin? || current_user.premium?)
   end

   def destroy?
     current_user.present? && (current_user.premium? || current_user.admin?)
  end
end
