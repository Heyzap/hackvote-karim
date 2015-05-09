require 'test_helper'

class ShowHackdayTest < ActionDispatch::IntegrationTest
  
  def setup
    @active_hackday = hackdays(:testHackday)
    @non_active_hackday = hackdays(:testHackday2)
  end

  test "should show error if incorrect new project" do
    project = @active_hackday.projects.build

    post projects_path, :project => {
      :title => "",
      :creators => ""
    }

    assert_template 'hackdays/show'
    assert_select '#error_explanation'
  end

  test "successfully removed active project" do
    assert project = @active_hackday.projects.first
    assert_difference 'Project.count', -1 do
      delete project_path(project)
    end

    follow_redirect!
    assert_no_match response.body, "Test Project 1"
  end
end
