require 'test_helper'

class HackdayTest < ActiveSupport::TestCase

  def setup
    @hackday = Hackday.new(:title => "Test Hackday", :held_at => Time.now)
  end

  test "is should be a valid" do
    assert @hackday.valid?
  end

  test "title should be present" do
    @hackday.title = nil
    assert_not @hackday.valid?
  end

  test "date held at should be present" do
    @hackday.held_at = nil
    assert_not @hackday.valid?
  end

end
