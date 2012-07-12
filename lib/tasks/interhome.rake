desc "Import properties from Interhome"
task :interhome => :environment do
  InterhomeImporter.import
end
