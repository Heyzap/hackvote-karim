class Hackday < ActiveRecord::Base
  has_many :projects, :dependent => :destroy

  before_destroy :check_active

  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :held_at, :presence => true

  def self.current
    where(:active => true)
  end

  def self.past
    where(:active => false)
  end

  private
  def check_active
    active?
  end

end
