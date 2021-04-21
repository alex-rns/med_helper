class ExpertsController < ApplicationController
  before_action :find_all_level, only: %i[edit update]
  before_action :find_all_category, only: %i[edit update]
  before_action :set_expert, only: %i[show edit update]
  before_action :correct_user, only: %i[index show]
  before_action :correct_expert, only: %i[edit update]

  def index
    @experts = Expert.searcher(params).paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def edit; end

  def update
    if @expert.update(expert_params)
      redirect_to @expert, success: 'Ваш профиль был изменён'
    else
      flash.now[:danger] = 'Ваш профиль не был изменён'
      render :edit
    end
  end

  private

  def correct_user
    if get_patient?
    else
      redirect_to home_path
    end
  end

  def correct_expert
    if get_doctor?
    else
      redirect_to home_path
    end
  end

  def set_expert
    @expert = Expert.find(params[:id])
  end

  def find_all_level
    @level = Level.all
  end

  def find_all_category
    @category = Category.all
  end

  def expert_params
    params.require(:expert).permit(:full_name, :description, :experience,
                                   :additional_education, :procedure, :address, :medical_center,
                                   :phone, :hw_start_monday, :hw_end_monday, :hw_start_tuesday, :hw_end_tuesday,
                                   :hw_start_wednesday, :hw_end_wednesday, :hw_start_thursday, :hw_end_thursday,
                                   :hw_start_friday, :hw_end_friday, :hw_start_saturday, :hw_end_saturday,
                                   :hw_start_sunday, :hw_end_sunday, :category_id, :education, :level_id, :image)
  end
end
