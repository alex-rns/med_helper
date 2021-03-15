class VisitsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @expert = Expert.find(params[:expert_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @expert = Expert.find(params[:expert_id])
    @visit = @event.build_visit(permit_params)
    if @visit.save
      redirect_to expert_event_visit(@expert, @event, @visit)
    else
      render 'new'
    end
  end

  def show
    @visit = Visit.find(params[:visit_id])
  end

  private

  def permit_params
    params.permit(:complaint, :therapy, :diagnosis, :state, :symptom, :anamnesis_of_life, :medical_history, :type_of_inspection)
  end
end
