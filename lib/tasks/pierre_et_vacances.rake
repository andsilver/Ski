namespace :pierre_et_vacances do
  desc 'Tidies up old data'
  task tidy: :environment do
    PvVacancy.delete_old
  end

  desc 'Import properties from Pierre et Vacances'
  task import: :environment do
    PierreEtVacances::Importer.import
  end
end
