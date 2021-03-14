module ApplicationHelper
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def render_stars(value)
    output = ''
    value.times { output += '⭐' } + (5-value).times { output += '☆' }
    output
  end
end
