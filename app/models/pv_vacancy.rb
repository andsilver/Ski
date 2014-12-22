class PvVacancy < ActiveRecord::Base
  # Deletes vacancies that have a start_date before today.
  def self.delete_old
    where(['start_date < ?', Date.today]).delete_all
  end
end
