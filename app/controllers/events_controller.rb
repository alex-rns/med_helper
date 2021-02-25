include EventsHelper

class EventsController < ApplicationController
  before_action :find_expert, only: [:new, :create, :show]
  before_action :find_user, only: [:new, :create, :show]

  def new
    @event = @expert.events.build
  end

  def create
    binding.pry
    @links = google_event(params)
    @event = @expert.events.build(event_params)
    if @event.save
      redirect_to expert_event_path(@expert, @event)
      flash[:notice] = "Заявка отправлена успешно!"
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
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
    params.require(:event).permit(:name, :phone, :email, :start_time, :end_time, :comment).merge(user_id: current_user.id).merge(calendar_link: @links.first).merge(meeting_link: @links.second)
  end

end
