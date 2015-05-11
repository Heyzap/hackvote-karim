require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @project = Project.new(:title => "Test Project", :creators => "Test Creators", :votes => 0)
    @active_project = projects(:testProject)
    @non_active_project = projects(:testProject2)
  end

  test "is should be a valid" do
    assert @project.valid?
  end

  test "title should be present" do
    @project.title = nil
    assert_not @project.valid?
  end

  test "creators at should be present" do
    @project.creators = nil
    assert_not @project.valid?
  end

  test "votes should be greater than or equal to 0" do
    @project.votes = -2
    assert_not @project.valid?
  end

  test "delete or change non active hackday project" do
    assert_not @non_active_project.update_attributes(:title => "change", :creators => "change", :votes => 3)
    assert_not @non_active_project.destroy
  end

  test "delete or change active hackday project" do
    @active_project.update_attributes(:title => "change", :creators => "change", :votes => 3)
    @active_project.reload

    assert @active_project.title, "change"
    assert @active_project.creators, "change"

    assert @active_project.destroy
  end
end
