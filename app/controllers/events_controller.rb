include EventsHelper
class EventsController < ApplicationController
  before_action :find_expert, only: %i[new create update]
  before_action :find_expert, only: %i[index], if: :get_doctor?
  before_action :get_patient_event, only: %i[index], if: :get_patient?
  before_action :get_doctor_event, only: %i[index], if: :get_doctor?
  before_action :correct_user, only: %i[new create]

  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build(expert: @expert)
  end

  def create
    params[:event][:end_time] = params[:event][:start_time].to_datetime + 1.hour
    @event = current_user.events.build(event_params)
    @event.pending!
    if @event.save
      redirect_to expert_event_path(@expert, @event)
      flash[:notice] = 'Заявка отправлена успешно! Ожидайте подтверждения врача!'
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    if params[:q] == 'approve'
      @links = google_event(@event)
      event = @event.approve!
      event.update(calendar_link: @links.first, meeting_link: @links.second)
    else
      event = @event.rejected!
    end
    redirect_to expert_events_path(@expert)
  end

  def check_time
    @time = params[:time]
    expert = Expert.find(params[:expert_id])
    @avail_time = available_time(expert, @time)
    render partial: 'time_slots'
  end

  private

  def correct_user
    if get_patient?
    else
      redirect_to home_path
    end
  end

  def get_patient_event
    @events = current_user.events
  end

  def get_doctor_event
    @events = @expert.events
  end

  def find_expert
    @expert = Expert.find(params[:expert_id])
  end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :comment, :type_of_call, :status)
              .merge(expert_id: @expert.id)
  end
end
