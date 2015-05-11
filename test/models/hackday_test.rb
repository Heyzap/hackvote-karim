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

  test "change or delete non active hackday" do
    @hackday.update_attribute(:active, false)
    assert_not @hackday.update_attribute(:title, "change")
    assert_not @hackday.destroy
  end

  test "change or delete active hackday" do
    @hackday.update_attribute(:active, true)
    @hackday.update_attribute(:title, "change")
    @hackday.reload

    assert @hackday.title, "change"
    assert @hackday.destroy
  end

end
