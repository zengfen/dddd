class EventsController < ApplicationController
	before_action :set_event, :only => [:show, :edit, :update, :destroy]
	def index
		@events = Event.page(params[:page]).per(5)
		respond_to do |format|
			format.html # index.html.erb
			format.xml{ render :xml => @events.to_xml }
			format.json{ render :json => @events.to_json }
			format.atom{ @feed_title = "My event list " } # indec.atom.builder
		end
	end

	def new
		@event = Event.new		
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to events_url
		else
			render :action => :new
		end
		flash[:notice] = "event was successfully created"
	end

	def show
		# @page_title = @event.name
		respond_to do |format|
			format.html { @page_title = @event.name } # show.html.erb
			format.xml # show.xml.builder
			format.json { render :json => { id: @event.id, name: @event.name }.to_json }
		end
	end

	def edit
	end

	def update
		@event.update(event_params)
		if @event.update(event_params)
			redirect_to event_url(@event)
		else 
			render :action => :edit
		end
		flash[:notice] = "event was successfully update"
	end

	def destroy
		@event.destroy

		redirect_to events_url
		flash[:notice] = "event was successfully delete"
	end

	private

	def event_params
		params.require(:event).permit(:name, :description, :category_id,
			:location_attributes => [:id, :name, :_destroy])
	end

	def set_event
		@event = Event.find(params[:id])
	end
end
