require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class EventsController < ApplicationController
  before_action :find_expert, only: [:new, :create, :show]
  before_action :find_user, only: [:new, :create, :show]
  CALENDAR_ID = 'primary'

  def new
    @event = @expert.events.build
  end

  def create
    # random_meet_id = "#{('a'..'z').to_a.shuffle[0,3].join}-#{('a'..'z').to_a.shuffle[0,4].join}-#{('a'..'z').to_a.shuffle[0,3].join}"
    attendees = 'matsakovamira156@gmail.com, nizizi53@gmail.com'.split(',').map{ |t| {email: t.strip} }
    client = get_google_calendar_client current_user
    event = Google::Apis::CalendarV3::Event.new({
      summary: "lalal",
      description: "ddjdjjd",
      start: {
        date_time: '2021-02-23T09:00:00-07:00',
      },
      end: {
        date_time: '2021-02-23T10:00:00-07:00',
      },
       attendees: attendees,
       conference_data: Google::Apis::CalendarV3::ConferenceData.new(
       create_request: Google::Apis::CalendarV3::CreateConferenceRequest.new(
       request_id: "sample123",
       conference_solution_key: Google::Apis::CalendarV3::ConferenceSolutionKey.new(
        type: "hangoutsMeet"
      )
    )
  )
    })
    client.insert_event('primary', event, conference_data_version: 1)

    @event = @expert.events.build(event_params)
    if @event.save
      redirect_to expert_event_path(@expert, @event)
      flash[:notice] = "Заявка отправлена успешно!"
      client
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def get_google_calendar_client current_user
  client = Google::Apis::CalendarV3::CalendarService.new
  secrets = Google::APIClient::ClientSecrets.new({
    "web" => {

      "access_token" => current_user.access_token,
      "refresh_token" => current_user.refresh_token,
      "client_id" => ENV["GOOGLE_CLIENT_ID"],
      "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
    }
  })
  client.authorization = secrets.to_authorization
  client.authorization.grant_type = "refresh_token"
  if !current_user.present?
    client.authorization.refresh!
    current_user.update_attributes(
      access_token: client.authorization.access_token,
      refresh_token: client.authorization.refresh_token,
      expires_at: client.authorization.expires_at.to_i
    )
  end
  client
end

  private

  def find_expert
    @expert = Expert.find(params[:expert_id])
  end

  def find_user
    unless user_signed_in?
      # store_location
      redirect_to new_user_session_path
    else
     current_user
   end
  end

  def event_params
    params.require(:event).permit(:name, :phone, :email, :time, :comment).merge(user_id: current_user.id)
  end

end
