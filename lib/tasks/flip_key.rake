desc 'Import properties from FlipKey'

namespace :flip_key do
  task import: :environment do
    FlipKey::Importer.new.import
  end
end
