require 'test_helper'

class HackdaysControllerTest < ActionController::TestCase
  
  def setup
    @active_hackday = hackdays(:testHackday)
    @non_active_hackday = hackdays(:testHackday2)
  end

  # test "should not remove a hackday that was not active" do
  #   assert_no_difference 'Hackday.count' do 
  #     delete :destroy, :id => @non_active_hackday.id
  #   end
  # end
  
end
