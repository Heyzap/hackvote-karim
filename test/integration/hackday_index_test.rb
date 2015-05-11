require 'test_helper'

class HackdayIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @hackday = hackdays(:testHackday)
  end

  test "invalid new hackday" do
    assert_no_difference 'Hackday.count' do
      post hackdays_path, :hackday => {
        :title => "",
        :held_at => Time.now
      }
    end

    assert_template 'hackdays/index'
    assert_select '#error_explanation'
  end

  test "valid new hackday" do
    assert_difference 'Hackday.count', 1 do
      post hackdays_path, :hackday => {
        :title => "Test",
        :held_at => Time.now
      }
    end

    follow_redirect!
    assert_template 'hackdays/show'
  end
end
