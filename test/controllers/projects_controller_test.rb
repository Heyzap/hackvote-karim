require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  def setup
    @active_hackday_project = projects(:testProject)
    @non_active_hackday_project = projects(:testProject2)
  end

  # test "shouldn't remove non active hackday project" do
  #   assert_no_difference 'Project.count' do
  #     delete :destroy, :id => @non_active_hackday_project.id
  #   end
  # end
end
