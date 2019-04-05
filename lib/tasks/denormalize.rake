desc "Denormalize database"
task denormalize: :environment do
  Denormalize.denormalize
end

desc "Cache availability"
task cache_availability: :environment do
  Denormalize.cache_availability
end

desc "Generate thumbnails"
task generate_thumbnails: :environment do
  Denormalize.generate_thumbnails
end
