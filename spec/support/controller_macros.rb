module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
  end

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in admin, scope: :user
    end
  end

  def login_premium
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:premium]
      premium = FactoryGirl.create(:premium)
      sign_in premium, scope: :user
    end
  end
end
