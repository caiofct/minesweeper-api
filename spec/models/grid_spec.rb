require 'rails_helper'

RSpec.describe Grid, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(build(:grid)).to be_valid
    end
  end

  context "validations" do
    before { create(:grid) }

    context "presence" do
      it { should validate_presence_of :width }
      it { should validate_presence_of :height }
      it { should validate_presence_of :number_of_mines }
    end

    context "number of squares" do
      let(:user) { create(:user, email: Faker::Internet.email) }
      let(:grid) { build(:grid, user: user, width: 10, height: 10, number_of_mines: 100) }
      it "shouldn't have more mines than squares" do
        expect(grid).not_to be_valid
      end
    end
  end
end
