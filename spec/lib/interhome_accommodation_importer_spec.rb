require 'spec_helper'
require 'xmlsimple'

describe InterhomeAccommodationImporter do
  describe '#import' do
    it 'runs setup' do
      i = InterhomeAccommodationImporter.new
      i.stub(:delete_all_adverts)
      i.should_receive(:setup)
      i.import []
    end

    it 'deletes all adverts' do
      i = InterhomeAccommodationImporter.new
      i.should_receive(:delete_all_adverts)
      i.stub(:setup)
      i.import []
    end
  end

  describe '#setup' do
    it 'finds the Euro currency, Interhome resort and interhome@mychaletfinder.com user' do
      User.should_receive(:find_by_email).with('interhome@mychaletfinder.com').and_return(true)
      Resort.should_receive(:find_by_name).with('Interhome').and_return(true)
      Currency.should_receive(:find_by_code).with('EUR').and_return(true)
      InterhomeAccommodationImporter.new.setup
    end
  end
end
