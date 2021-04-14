class PacientsController < ApplicationController
  def index
    @events = Event.where(expert_id: current_user.expert.id).where(status: 'approve').uniq(&:user_id)
  end
end
