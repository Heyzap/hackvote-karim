class Project < ActiveRecord::Base
  belongs_to :hackday

  validates :title, :presence => true, :length => { :maximum => 255 }
  validates :creators, :presence => true, :length => { :maximum => 255 }
  validates :votes, :numericality => { :greater_than_or_equal_to => 0 }

end
