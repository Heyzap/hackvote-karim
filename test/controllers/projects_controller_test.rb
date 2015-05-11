require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  def setup
    @active_hackday_project = projects(:testProject)
    @non_active_hackday_project = projects(:testProject2)
  end

  test "shouldn't be able to downvote a 0 vote project" do
    assert_no_difference '@active_hackday_project.votes' do
      patch :downvote, :id => @active_hackday_project.id
    end
  end

  test "shouldn't be able to upvote with no votes" do
    3.times { patch :downvote, :id => @active_hackday_project.id }
    assert_no_difference '@active_hackday_project.votes' do
      patch :downvote, :id => @active_hackday_project.id
    end
  end

end
