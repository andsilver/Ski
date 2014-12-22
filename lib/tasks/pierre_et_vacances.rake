namespace :pierre_et_vacances do
  desc 'Import properties from Pierre et Vacances'
  task import: :environment do
    PierreEtVacances::Importer.import
  end
end
