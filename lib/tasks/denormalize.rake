desc "Denormalize database"
task :denormalize => :environment do
  Denormalize.denormalize
end

desc "Cache unavailability"
task :cache_unavailability => :environment do
  Denormalize.cache_unavailability
end
