require 'rails_helper'

RSpec.describe Rank, type: :model do
  describe '.validate :score_range' do
    context 'valid rank' do
      let(:valid_subject) {Rank.new(name: 'SomeName', score_from: 1, score_to: 2)}
      it_behaves_like 'ValidRank'
    end

    context 'invalid rank' do
      let(:invalid_subject) {Rank.new(name: 'SomeName', score_from: 10, score_to: 1)}

      it 'add error message to subject.errors if subject is invalid' do
        invalid_subject.save
        expect(invalid_subject.errors[:wrong_score].first).to eq 'The score is not valid'
      end

      it "doesn't create a new rank" do
        expect {invalid_subject.save}.to_not change(Rank, :count)
      end
    end
  end

  describe '.validate :overlapping' do
    let!(:rank) {FactoryGirl.create(:rank, score_from: 11, score_to: 20)}

    context 'valid rank' do
      let(:valid_subject) {Rank.new(name: 'SomeName', score_from: 1, score_to: 10)}
      it_behaves_like 'ValidRank'
    end

    context 'score_from and score_to are in overlapping range' do
      let(:invalid_subject) {Rank.new(name: 'SomeName', score_from: 11, score_to: 17)}
      it_behaves_like 'OverlappingScore'
    end

    context 'score_from are in overlapping range' do
      let(:invalid_subject) {Rank.new(name: 'SomeName', score_from: 12, score_to: 30)}
      it_behaves_like 'OverlappingScore'
    end

    context 'score_to are in overlapping range' do
      let(:invalid_subject) {Rank.new(name: 'SomeName', score_from: 9, score_to: 20)}
      it_behaves_like 'OverlappingScore'
    end
  end
end