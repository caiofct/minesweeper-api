require 'rails_helper'

RSpec.describe Square, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(build(:square)).to be_valid
    end
  end

  context "validations" do
    before { create(:square) }

    context "presence" do
      it { should validate_presence_of :x }
      it { should validate_presence_of :y }
    end
  end

  context "adjacents" do
    let(:grid) { create(:grid, width: 3, height: 3, number_of_mines: 1) }

    it "returns the correct adjacents of a square" do
      expect(grid.squares.first.adjacents(true).count).to eq 3
    end
  end

  context "toggle mine!" do
    let(:grid) { create(:grid, width: 1, height: 2, number_of_mines: 1) }

    it "returns the correct adjacents of a square" do
      square = grid.squares.where(mine: false).first
      square2 = grid.squares.where(mine: true).first
      expect(square.mines).to eq 1
      square.turn_mine!
      expect(square.mines).to eq -1
      expect(square2.mines).to eq -1
    end
  end

  context "toogle flag!" do
    let(:grid) { create(:grid, width: 2, height: 2, number_of_mines: 2) }

    it "succesfully toogles a square flag" do
      grid.squares.first.toggle_flag!
      expect(grid.squares.first.flagged).to eq true
      expect(grid.status).to eq "playing"
    end

    it "win the game when all mines have been flagged" do
      grid.squares.where(mine: true).each { |square| square.toggle_flag! }
      expect(grid.status).to eq "game_won"
    end
  end

  context "explore!" do
    let(:grid) { create(:grid) }

    it "succesfully explores a non mine square" do
      grid.squares.where(mine: false).first.explore!
      expect(grid.status). to eq "playing"
    end

    it "game over when exploring a mine square" do
      grid.squares.where(mine: true).first.explore!
      expect(grid.status). to eq "game_over"
    end
  end
end
