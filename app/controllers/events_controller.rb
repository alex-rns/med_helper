class EventsController < ApplicationController
  before_action :find_expert, only: [:new, :create, :show]
  before_action :find_user, only: [:new, :create, :show]

  def new
    @event = @expert.events.build
  end

  def create
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
    else
     current_user
   end
  end

  def event_params
    params.require(:event).permit(:name, :phone, :email, :time, :comment).merge(user_id: current_user.id)
  end

end