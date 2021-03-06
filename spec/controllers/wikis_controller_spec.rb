require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_admin_user) { create(:admin) }
  let(:my_premium_user) { create(:premium) }

  let(:my_wiki) { create(:wiki, user: my_user, private: false) }
  let(:my_private_wiki) { create(:wiki, user: my_premium_user, private: true) }

  context "standard user" do
    describe "GET #index" do
      login_user
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "does not include private wikis in @wikis" do
        get :index
        expect(assigns(:wikis)).not_to include(my_private_wiki)
      end
    end

    describe "GET #show" do
      login_user
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end

      it "redirects from private wikis" do
        get :show, id: my_private_wiki.id
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #new" do
      login_user
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "GET #edit" do
      login_user
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template :edit
      end

      it "assigns the wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id

        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
        expect(wiki_instance.user).to eq my_wiki.user
      end
    end

    describe "POST #create" do
      login_user
      it "increases the number of Wikis by 1" do
        expect do
          post :create, wiki: { title: "Third Title",
                                body: "This is my third body",
                                private: false,
                                user: my_user }
        end.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: { title: "The 4th Title",
                              body: "This is my 4th body",
                              private: false,
                              user: my_user }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: { title: "The 5th Title",
                              body: "This is my 5th body",
                              private: false,
                              user: my_user }
        expect(assigns(:wiki)).to redirect_to Wiki.last
      end
    end
  end

  context "admin user" do
    describe "PUT #update" do
      login_admin
      it "updates wiki with expected attributes for admin users" do
        new_title = "This is a new title"
        new_body = "This is a new body"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }

        updated_wiki = assigns(:wiki)

        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "This is a new title"
        new_body = "This is a new body"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE #destroy" do
      login_admin
      it "deletes the wiki for admin users" do
        delete :destroy, id: my_wiki.id
        count = Wiki.where(id: my_wiki.id).size
        expect(count).to eq 0
      end

      it "redirects to root_path" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to root_path
      end
    end
  end

  context "standard user" do
    describe "PUT #update" do
      login_user
      it "updates wiki with expected attributes users" do
        new_title = "This is a new title"
        new_body = "This is a new body"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }

        updated_wiki = assigns(:wiki)

        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "This is a new title"
        new_body = "This is a new body"

        put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body }
        expect(response).to redirect_to my_wiki
      end
    end
  end
end
