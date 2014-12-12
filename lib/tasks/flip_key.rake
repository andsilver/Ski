desc 'Import properties from FlipKey'

namespace :flip_key do
  task destroy_stale_properties: :environment do
    FlipKeyProperty.stale.destroy_all
  end

  task import: :environment do
    FlipKey::Importer.new.import
  end
end
