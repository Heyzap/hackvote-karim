class Hackday < ActiveRecord::Base
  has_many :projects, :dependent => :destroy

  before_save :active_check
  before_destroy :active_check

  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :held_at, :presence => true

  scope :past, -> {
    if last && last.active?
      order("id DESC")[1..-1]
    else
      order("id DESC")
    end
  }

  def self.current
    last if last && last.active?
  end

  private
  def active_check
    unless active_was
      errors.add :base, "Non-Active Hackdays cannot be deleted for modified"
      return false
    end
  end

end
