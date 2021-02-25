module ExpertsHelper
  def selector_element(arr)
    abc = arr.each_with_index.map { |x,i| [x.name, i+1] }
    abc
  end

  def set_time
    time = (0..23).map {|x| [x.to_s+":"+"00", "#{x}"+":"+"00"]}
    time
  end

  def time_slot(start, ends)
    num_start = start.to_i
    num_end = ends.to_i
    time = (num_start..num_end).map {|x| Time.parse(x)}
    time
  end
end
