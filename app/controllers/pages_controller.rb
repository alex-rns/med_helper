class PagesController < ApplicationController

  def home
    Rails.logger.error request.cookies
  end
end
