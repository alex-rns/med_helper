class PagesController < ApplicationController
  def home
    Rails.logger.error request.cookies
  end

  def rule
  end
end
