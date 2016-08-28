require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:my_user) { create(:user) }
  let(:my_admin_user) { create(:admin) }
  let(:my_premium_user) { create(:premium) }

  let(:my_wiki) { create(:wiki, user: my_user)}
  let(:my_private_wiki) { create(:wiki, user: my_premium_user, private: true)}

  context "premium user" do

    describe "POST #downgrade" do
    login_premium

      it "downgrades the user to a standard role" do
        put :downgrade, {id: my_premium_user.id}
        downgraded_user = assigns(:user)
        expect(downgraded_user.role).to eq 'standard'
      end

      it "publicizes all of the user's private wikis" do
        put :downgrade, {id: my_premium_user.id}
        count = Wiki.where({private: true}).size
        expect(count).to eq 0
      end
    end
  end
end
