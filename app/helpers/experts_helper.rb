# frozen_string_literal: true

require 'time'
module ExpertsHelper
  def set_address(address)
    address.split(' ').join('+')
  end

  def selector_element(arr)
    arr.each_with_index.map { |x, i| [x.name, i + 1] }
  end

  def set_time
    (0..23).map { |x| %W[#{x}:00 #{x}:00] }
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
    expert.events.each { |ev| arr << (ev.start_time.hour..ev.end_time.hour).to_a }
    arr.flatten
  end
end
