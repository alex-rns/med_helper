include EventsHelper

class EventsController < ApplicationController
  before_action :find_expert, only: [:new, :create, :show, :update]
  before_action :find_user, only: [:new, :create, :show]

  def index
    @events = current_user.events
  end

  def new
    is_patient?
    @event = @expert.events.build
  end

  def create
    params[:event][:end_time] = params[:event][:start_time].to_datetime+1.hour
    @event = @expert.events.create(event_params)
    @event.pending!
    if @event.save
      redirect_to expert_event_path(@expert, @event)
      flash[:notice] = "Заявка отправлена успешно! Ожидайте подтверждения врача!"
    else
      render 'new'
    end
  end

  def update
    if params[:q]=='approve'
      event = Event.find(params[:id])
      @links = google_event(event)
      @event = event.approve!
      event.update(calendar_link: @links.first, meeting_link: @links.second)
      redirect_to expert_events_path(@expert)
    else
      event = Event.find(params[:id])
      @event = event.rejected!
      redirect_to expert_events_path(@expert)
    end
  end

  def show
    @event = current_user.events.find(params[:id])
  end

  def check_time
    @time = params[:time]
    expert = Expert.find(params[:expert])
    @avail_time = available_time(expert, @time)
    render partial: "time_slots"
  end

  private
  def find_expert
    @expert = Expert.find(params[:expert_id])
  end

  def find_user
    unless user_signed_in?
      redirect_to new_user_session_path
    else
     current_user
   end
  end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :comment, :type_of_call, :status).merge(user_id: current_user.id)
  end
end
