class Project < ActiveRecord::Base
  belongs_to :hackday

  before_save :hackday_active

  default_scope -> { order(:votes => :desc) }

  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :creators, :presence => true, :length => { :maximum => 255 }
  validates :votes, :numericality => { :greater_than_or_equal_to => 0 }

  private
  def hackday_active
    unless hackday.active?
      errors.add :base, "The Hackday for this project is closed to voting"
      return false
    end
  end
end
