class Hackday < ActiveRecord::Base
  has_many :projects, :dependent => :destroy

  before_save :active_was
  before_destroy :active?

  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :held_at, :presence => true

  def self.current
    last if last && last.active?
  end

  def self.past
    if last && last.active?
      order("id DESC")[1..-1]
    else
      order("id DESC")
    end
  end

  private
  def check_active

  end

end
