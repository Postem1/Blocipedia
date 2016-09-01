require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let (:wiki) { Wiki.create!(title: "New Wiki Title", body: "This is a new wiki that I created", private: false) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "This is a new wiki that I created", private: false)
    end
  end

  it { is_expected.to have_many(:collaborators) }
  it { is_expected.to have_many(:users).through(:collaborators) }
  it { is_expected.to belong_to(:user) }


end
