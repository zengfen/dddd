class Event < ActiveRecord::Base
	validates_presence_of :name
	has_many :attendees , :dependent => :destroy #复数
	belongs_to :category
	has_one :location, :dependent => :destroy
	has_many :event_groupships
	has_many :groups, :through => :event_groupships
	accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank
end
