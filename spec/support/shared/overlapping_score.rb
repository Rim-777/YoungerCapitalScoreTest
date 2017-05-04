shared_examples_for 'OverlappingScore' do

  it 'add error message to subject.errors if subject is invalid' do
    invalid_subject.save
    expect(invalid_subject.errors[:overlapping_score].first).to eq 'The score is overlapping'
  end

  it "doesn't create a new rank" do
    expect {invalid_subject.save}.to_not change(Rank, :count)
  end
end