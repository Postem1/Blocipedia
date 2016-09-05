require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_admin_user) { create(:admin) }
  let(:my_premium_user) { create(:premium) }

  let(:my_wiki) { create(:wiki, user: my_user) }
  let(:my_private_wiki) { create(:wiki, user: my_premium_user, private: true) }

  let(:my_collabo) { create(:collaborator, wiki: my_private_wiki, user: my_user) }

  describe "GET #new" do
    login_admin

    it "returns http success" do
      get :new, wiki_id: my_private_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new, wiki_id: my_private_wiki.id
      expect(response).to render_template :new
    end

    it "instantiates @collaborator" do
      get :new, wiki_id: my_private_wiki.id
      expect(assigns(:collaborator)).not_to be_nil
    end
  end

  describe "POST #create" do
    login_admin

    it "increases the number of collaborators by 1" do
      expect do
        post :create, wiki_id: my_private_wiki.id, collaborator: { wiki: my_private_wiki, user: my_user }
      end.to change(Collaborator, :count).by(1)
    end

    it "assigns the new collaborator to @collaborator" do
      post :create, wiki_id: my_private_wiki.id, collaborator: { wiki: my_private_wiki, user: my_user }
      expect(assigns(:collaborator)).to eq Collaborator.last
    end

    it "redirects to wiki" do
      post :create, wiki_id: my_private_wiki.id, collaborator: { wiki: my_private_wiki, user: my_user }
      expect(assigns(:collaborator)).to redirect_to(my_private_wiki)
    end
  end

  describe "DELETE #destroy" do
    login_admin

    it "deletes the collaborator" do
      delete :destroy, wiki_id: my_private_wiki.id, id: my_collabo.id
      count = Collaborator.where(id: my_collabo.id).size
      expect(count).to eq 0
    end

    it "redirects to root_path" do
      delete :destroy, wiki_id: my_private_wiki.id, id: my_collabo.id
      expect(response).to redirect_to(my_private_wiki)
    end
  end
end
