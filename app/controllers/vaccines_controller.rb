class VaccinesController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :set_vaccine, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    @vaccines.update(vaccines_params)
    if params[:child_id].present?
      redirect_to user_child_vaccine_path(@user), success: 'Карта вакцинации Вашего ребёнка обновлена'
    else
      redirect_to user_vaccine_path(@user), success: 'Ваша карта вакцинации обновлена'
    end
  end

  private

  def set_user
    @user = if params[:child_id].present?
              Child.find(params[:id])
            else
              User.find(params[:id])
            end
  end

  def set_vaccine
    @vaccines = @user.vaccine
  end

  def vaccines_params
    params.permit(:hepatitis_a_1w, :hepatitis_a_2w, :hepatitis_b_1w, :hepatitis_b_2w, :hepatitis_b_3w,
                  :tuberculosis, :pneumococcus_1w, :pneumococcus_2w, :pneumococcus_3w, :meningococcus_1w,
                  :meningococcus_2w, :varicella_1w, :varicella_2w, :morbilli_mumps_rubella_1w,
                  :morbilli_mumps_rubella_2w, :diphtheria_tetanus_pertussis_1w, :diphtheria_tetanus_pertussis_2w,
                  :diphtheria_tetanus_pertussis_3w, :diphtheria_tetanus_pertussis_1rw,
                  :diphtheria_tetanus_pertussis_2rw, :diphtheria_tetanus_pertussis_3rw, :hib_desease_1w,
                  :hib_desease_2w, :hib_desease_3w, :hib_desease_4w, :rota_1w, :rota_2w, :covid19_1w, :covid19_2w)
  end
end
