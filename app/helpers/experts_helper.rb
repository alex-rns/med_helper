require 'time'
module ExpertsHelper

  def set_address(address)
    address.split(' ').join("+")
  end

  def selector_element(arr)
    abc = arr.each_with_index.map { |x, i| [x.name, i + 1] }
    abc
  end

  def set_time
    time = (0..23).map { |x| [x.to_s + ":" + "00", "#{x}" + ":" + "00"] }
    time
  end

  def check_params(expert, time)
    x = Time.now.strftime('%A').downcase
    start_time = expert.send("hw_start_#{x}").to_i
    end_time = expert.send("hw_end_#{x}").to_i
    event_time = check_event(expert)
    time >= Time.now && (start_time..end_time).include?(time.hour) && event_time.exclude?(time.hour)
  end

  def check_event(expert)
    arr = []
    expert.events.each do |ev|
      arr << (ev.start_time.hour..ev.end_time.hour).to_a
    end
    arr.flatten
  end
end
