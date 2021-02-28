class VaccinesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_vaccine, only: [:show, :edit, :update]

  def show
    @vaccines = @user.vaccine
  end

  def edit
  end

  def update
    @vaccines.update(vaccines_params)
    redirect_to user_vaccine_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
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
