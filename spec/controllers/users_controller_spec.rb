require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_admin_user) { create(:admin) }
  let(:my_premium_user) { create(:premium) }

  context "premium user" do
    describe "POST #downgrade" do
      login_premium
      before do
        @private_wiki = Wiki.create!(title: "A test title", body: "A test body",
                                     private: false, user: my_premium_user)
      end

      it "downgrades the user to a standard role" do
        put :downgrade, id: my_premium_user.id
        downgraded_user = assigns(:user)
        expect(downgraded_user.role).to eq 'standard'
      end

      it "publicizes all of the user's private wikis" do
        put :downgrade, id: my_premium_user.id
        count = Wiki.where(private: true).size
        expect(count).to eq 0
      end
    end
  end
end
