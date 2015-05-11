require 'test_helper'

class ShowHackdayTest < ActionDispatch::IntegrationTest
  MAX_VOTES = 3
  
  def setup
    @active_hackday = hackdays(:testHackday)
    @non_active_hackday = hackdays(:testHackday2)
    @active_hackday_project = projects(:testProject)
    @non_active_hackday_project = projects(:testProject2)
    cookies["#{@active_hackday.id}_votes"] = MAX_VOTES
  end

  test "upvote and downvote" do
    assert_difference '@active_hackday_project.reload.votes', 1 do
      patch upvote_project_path(@active_hackday_project)
    end

    assert_difference '@active_hackday_project.reload.votes', -1 do
      patch downvote_project_path(@active_hackday_project)
    end
  end

  test "downvoting with max votes" do
    assert_no_difference cookies["#{@active_hackday_project.hackday.id}_votes"] do
      patch downvote_project_path(@active_hackday_project)
    end
  end

  test "downvoting project with 0 votes" do
    assert_no_difference '@active_hackday_project.votes' do
      patch downvote_project_path(@active_hackday_project)
    end
  end

  test "invalid project creation" do
    assert_no_difference 'Project.count' do
      post projects_path, :hackday_id => @active_hackday.id, :project => {
        :title => "",
        :creators => ""
      }
    end

    assert_template 'hackdays/show'
    assert_select '#error_explanation'
  end

  test "valid project creation" do
    assert_difference 'Project.count', 1 do
      post projects_path, :hackday_id => @active_hackday.id, :project => {
        :title => "New Project",
        :creators => "Creators"
      }
    end
    
    follow_redirect!
    assert_template 'hackdays/show'
    assert_match "New Project", response.body
  end

  test "close voting" do
    patch close_voting_hackday_path(@active_hackday)
    follow_redirect!
    assert_template 'hackdays/show'

    assert_select 'a', :text => "change", :count => 0
    assert_select 'a', :text => "delete", :count => 0
    assert_select 'a', :text => "edit", :count => 0
    assert_select 'a', :text => "upvote", :count => 0
    assert_select 'a', :text => "downvote", :count => 0
  end
end
