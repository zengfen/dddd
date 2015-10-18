class Attendee < ActiveRecord::Base
	belongs_to :event   #单数
end
