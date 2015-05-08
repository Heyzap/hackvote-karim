require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @project = Project.new(:title => "Test Project", :creators => "Test Creators", :votes => 0)
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
end
