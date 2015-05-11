module UserVotes
  extend ActiveSupport::Concern

  MAX_VOTES = 3

  def user_votes
    (session["#{@hackday.id}_votes"] || MAX_VOTES).to_i
  end

  def set_votes(vote)
    session["#{@hackday.id}_votes"] = vote
  end
end