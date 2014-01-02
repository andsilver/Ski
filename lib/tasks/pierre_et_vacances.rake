desc 'Import properties from Pierre et Vacances'
task pierre_et_vacances: :environment do
  PierreEtVacances::Importer.import
end
