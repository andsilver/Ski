require 'rails_helper'
require 'xmlsimple'

module Interhome
  describe AccommodationImporter do
    describe '#import_pictures' do
      let(:accommodation) { FactoryGirl.create(:interhome_accommodation) }
      context 'with pictures containing all properties' do
        let(:a) {
          {
            'pictures' =>
            [
              {
                'picture' => [
                  {
                    'url' => ['#'],
                    'type' => ['i'],
                    'season' => ['s']
                  }
                ]
              }
            ]
          }
        }
        it 'adds a picture with given properties' do
          importer = AccommodationImporter.new
          importer.import_pictures(accommodation, a)
          p = accommodation.interhome_pictures.last
          expect(p.picture_type).to eq 'i'
        end
      end

      context 'with pictures missing properties' do
        let(:a) {
          {
            'pictures' =>
            [
              {
                'picture' => [
                  {
                  }
                ]
              }
            ]
          }
        }
        it 'adds a picture with missing properties' do
          importer = AccommodationImporter.new
          importer.import_pictures(accommodation, a)
          expect(accommodation.interhome_pictures.count).to eq 1
        end
      end
    end
  end
end
