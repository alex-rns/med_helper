module VaccinesHelper
  def vaccination_permit?(months_count)
    Time.now - @user.birthday > months_count.months
  end
end
