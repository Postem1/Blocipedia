require 'rails_helper'

describe WikiPolicy do
  subject { WikiPolicy }

  permissions :destroy? do
    it "denies access if user is not an admin" do
      expect(subject).not_to permit(FactoryGirl.create(:user), Wiki.create(private: false))
    end

    it "allows admin to destroy wikis" do
      expect(subject).to permit(FactoryGirl.create(:admin), Wiki.create(private: false))
    end
  end

  permissions :edit? do
    it "grants access to standard user if wiki is public" do
      expect(subject).to permit(FactoryGirl.create(:user), Wiki.create(private: false))
    end
  end
end
