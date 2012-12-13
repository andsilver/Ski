desc "Import properties from Interhome"
task :interhome => :environment do
  Interhome::Importer.import
end
