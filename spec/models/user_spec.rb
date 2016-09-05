require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:collaborators) }
end
