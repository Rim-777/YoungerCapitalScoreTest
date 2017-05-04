shared_examples_for 'ValidRank' do
  it "doesn't add error message to subject.errors if subject is valid" do
    valid_subject.save
    expect(valid_subject.errors[:wrong_score].first.blank?).to eq true
  end

  it 'create a new rank' do
    expect {valid_subject.save}.to change(Rank, :count).by(1)
  end
end