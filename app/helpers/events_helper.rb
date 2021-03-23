module EventsHelper
  require "google/apis/calendar_v3"
  require "google/api_client/client_secrets.rb"

  def google_event(event)
    user_email = event.user.email
    expert_email = current_user.email
    attendees = "#{user_email}, #{expert_email}".split(',').map{ |t| {email: t.strip} }
    client = get_google_calendar_client current_user
    event = Google::Apis::CalendarV3::Event.new({
      summary: event.comment,
      description: "Пациент: #{event.user.card.full_name}",
      start: {
         date_time: event.start_time.to_datetime,
      },
      end: {
        date_time: event.end_time.to_datetime,
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
    new_event = client.insert_event('primary', event, conference_data_version: 1)
    event_link = [new_event.html_link, new_event.hangout_link]
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
    client.authorization.fetch_access_token!
    client.authorization
    client
  end

end
