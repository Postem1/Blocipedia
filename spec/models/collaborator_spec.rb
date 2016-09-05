require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:my_premium_user) { create(:premium) }
  let(:my_user) { create(:user) }

  let(:my_private_wiki) { create(:wiki, user: my_premium_user, private: true) }

  let(:my_collabo) { create(:collaborator, wiki: my_private_wiki, user: my_user) }

  describe "attributes" do
    it "has user and wiki attributes" do
      expect(my_collabo).to have_attributes(user: my_user, wiki: my_private_wiki)
    end
  end

  it { is_expected.to belong_to(:wiki) }
  it { is_expected.to belong_to(:user) }
end
