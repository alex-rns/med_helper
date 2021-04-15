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
  def available_time(expert, time)
    day_of_week = time.to_datetime.strftime("%A").downcase
    start_time = expert.send("hw_start_#{day_of_week}").to_i
    end_time =  expert.send("hw_end_#{day_of_week}").to_i
    set_time = (start_time..end_time).to_a
    time_now = (0..Time.now.hour).to_a
    event_time = get_event(expert, time)
    if Time.now.strftime("%Y-%m-%d") == time
      availiabe = set_time - event_time - time_now
    else
      availiabe = set_time - event_time
    end
    arr = {}
    if day_of_week == 0
      return arr[0] = availiabe
    elsif day_of_week == 1
      return arr[1] = availiabe
    elsif day_of_week == 2
      return arr[2] = availiabe
    elsif day_of_week == 3
      return arr[3] = availiabe
    elsif day_of_week == 4
      return arr[4] = availiabe
    elsif day_of_week == 5
      return arr[5] = availiabe
    else
      return arr[6] = availiabe
    end
  end

  def get_event(expert, time)
    arr = []
    events = expert.events
                   .where(start_time:time.to_datetime.beginning_of_day...time.to_datetime.end_of_day)
                   .where(status: [:approve, :pending])
    events.each do |ev|
      arr << ev.start_time.hour
    end
    arr.flatten.uniq
  end
end
