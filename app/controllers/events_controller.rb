class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  
  def index
    @events = Event.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Event Created"
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    # @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      flash.notice = "Event updated!"
      redirect_to(@event)
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash.now[:notice] = "Event deleted"
      redirect_to events_path
    else
      render @event
    end
  end
  
  private
  
  def event_params
      params.require(:event).permit(:name)
  end
  
  def set_event
    @event = Event.find(params[:id])
  end

end
