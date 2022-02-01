require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relations" do
    it { should have_many(:user_parties)}
    it { should have_many(:parties).through(:user_parties)}
  end
end