desc 'Import properties from FlipKey'
task flip_key: :environment do
  FlipKey::Importer.new.import
end
