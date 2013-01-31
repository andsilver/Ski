require 'spec_helper'
require 'xmlsimple'

module Interhome
  describe AccommodationImporter do
    describe '#import' do
      it 'runs setup' do
        i = AccommodationImporter.new
        i.stub(:delete_all_adverts)
        i.should_receive(:setup)
        i.import [], false
      end

      context 'with cleanup set to true' do
        it 'deletes old adverts' do
          i = AccommodationImporter.new
          i.should_receive(:delete_old_adverts)
          i.stub(:setup)
          i.interhome = User.new
          i.import [], true
        end
      end

      context 'with cleanup set to false' do
        it 'does not delete old adverts' do
          i = AccommodationImporter.new
          i.should_not_receive(:delete_old_adverts)
          i.stub(:setup)
          i.import [], false
        end
      end
    end

    describe '#setup' do
      it 'finds the Euro currency and interhome@mychaletfinder.com user' do
        User.should_receive(:find_by_email).with('interhome@mychaletfinder.com').and_return(true)
        Currency.should_receive(:find_by_code).with('EUR').and_return(true)
        AccommodationImporter.new.setup
      end
    end
  end
end
