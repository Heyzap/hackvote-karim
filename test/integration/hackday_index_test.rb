require 'test_helper'

class HackdayIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @hackday = hackdays(:test)
  end

  test "should redirect with error if incorrect new hackday" do
    post hackdays_path, :hackday => {
      :title => "",
      :held_at => Time.now
    }

    assert_template 'hackdays/index'
    assert_select '#error_explanation'
  end

end
