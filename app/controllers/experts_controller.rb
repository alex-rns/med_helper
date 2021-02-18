class ExpertsController < ApplicationController
  def index
    @experts = Expert.searcher(params)
  end

  def show
    @expert = Expert.find(params[:id])
  end
end
