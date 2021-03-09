class ExpertsController < ApplicationController
  before_action :find_all_level, only: [:edit, :update]
  before_action :find_all_category, only: [:edit, :update]

  def index
    @experts = Expert.searcher(params).paginate(page: params[:page], per_page: 5)
  end

  def show
    @expert = Expert.find(params[:id])
  end

  def edit
    @expert = Expert.find(params[:id])
  end

  def update
    @expert = Expert.find(params[:id])
    if @expert.update(expert_params)
      redirect_to @expert
    else
      render :edit
    end
  end

  private

  def find_all_level
    @level = Level.all
  end

  def find_all_category
    @category = Category.all
  end

  def expert_params
    params.require(:expert).permit(:full_name, :description, :experience,
      :additional_education, :procedure, :address, :medical_center, :email,
      :phone, :hw_start_monday, :hw_end_monday, :hw_start_tuesday, :hw_end_tuesday,
      :hw_start_wednesday, :hw_end_wednesday, :hw_start_thursday, :hw_end_thursday,
      :hw_start_friday, :hw_end_friday, :hw_start_saturday, :hw_end_saturday,
      :hw_start_sunday, :hw_end_sunday, :category_id,:education,:level_id, :image)
  end

end
