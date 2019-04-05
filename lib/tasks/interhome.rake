desc "Import properties from Interhome"
task interhome: :environment do
  Interhome::Importer.new.import
end
