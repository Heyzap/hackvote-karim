module ApplicationHelper
  MAX_VOTES = 3

  private
  def user_votes
    (cookies["#{@hackday.id}_votes"] || MAX_VOTES).to_i
  end

  def set_votes(vote)
    cookies["#{@hackday.id}_votes"] = vote
  end

end
