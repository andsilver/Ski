desc "Denormalize database"
task :denormalize => :environment do
  Denormalize.denormalize
end
