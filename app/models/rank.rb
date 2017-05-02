class Rank < ActiveRecord::Base
  validates :name, presence: true
  validate :score_range, :overlapping

  private
  def score_range
    errors.add(:wrong_score, 'The score is not valid') unless score_is_valid?
  end

  def overlapping
    errors.add(:overlapping_score, 'The score is overlapping') if score_is_overlapping?
  end

  def score_is_valid?
    !!(score_from < score_to)
  end

  def score_is_overlapping?
    !!( Rank.where(
       "(score_from <= ? AND score_to >= ?) OR
        (score_from <= ? AND score_to >= ?) OR
        (score_from >= ? AND score_to <= ?)",
        score_from, score_from, score_to, score_to, score_from, score_to).first
    )
  end
end
