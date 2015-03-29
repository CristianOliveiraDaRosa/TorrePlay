class Video < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  acts_as_votable

  validates :url, presence: true
  validates :title, presence: true

  @@valid_score = true

  def liked_by(user)
    vote_up(user)
    self.user.scores_by_like
  end

  def unliked_by(user)
    vote_down(user)
    self.user.scores_by_unlike
  end

  def disliked_by(user)
    unvote_up(user)
    self.user.scores_by_unlike
  end

  def undisliked_by(user)
    unvote_down(user)
    self.user.scores_by_unlike
  end

  def invalidate_score!
    @@valid_score = false
  end

  def is_valid_score?
    @@valid_score
  end

end
