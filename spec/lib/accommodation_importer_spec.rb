require 'rails_helper'

describe AccommodationImporter do
  Accommodation = Struct.new(:dummy)

  describe '#import' do
    it 'runs setup' do
      i = AccommodationImporter.new
      expect(i).to receive(:setup)
      i.import []
    end
  end

  describe '#setup' do
    it 'finds the Euro currency and user by email' do
      i = AccommodationImporter.new
      allow(i).to receive(:user_email).and_return('somebody@example.org')
      expect(User).to receive(:find_by).with(email: 'somebody@example.org').and_return(true)
      expect(Currency).to receive(:find_by).with(code: 'EUR').and_return(true)
      i.setup
    end
  end

  describe '#cleanup' do
    it 'deletes old adverts' do
      i = AccommodationImporter.new
      expect(i).to receive(:delete_old_adverts)
      allow(i).to receive(:setup)
      allow(i).to receive(:destroy_all)
      i.user = User.new
      i.cleanup
    end

    it 'destroys all accommodations' do
      i = AccommodationImporter.new
      expect(i).to receive(:destroy_all)
      allow(i).to receive(:setup)
      allow(i).to receive(:delete_old_adverts)
      i.cleanup
    end
  end

  describe '#delete_old_adverts' do
    it 'deletes adverts belonging to the user updated before the import ' \
    'start time' do
      start = Time.new(2017, 8, 6, 10, 0, 30)
      user = FactoryGirl.create(:user)
      a1 = FactoryGirl.create(:advert, user: user, updated_at: start - 1.second)
      a2 = FactoryGirl.create(:advert, user: user, updated_at: start + 1.second)
      a3 = FactoryGirl.create(:advert, updated_at: start - 1.second)
      i = AccommodationImporter.new
      i.user = user
      i.import_start_time = start

      i.delete_old_adverts

      expect(Advert.exists?(a1.id)).to be_falsey
      expect(Advert.exists?(a2.id)).to be_truthy
      expect(Advert.exists?(a3.id)).to be_truthy
    end
  end

  describe '#destroy_all' do
    it 'destroys all accommodation objects updated before the import began' do
      i = AccommodationImporter.new
      allow(i).to receive(:model_class).and_return(Accommodation)
      start_time = Time.now
      i.import_start_time = start_time
      expect(Accommodation).to receive(:destroy_all).with(['updated_at < ?', start_time])
      i.destroy_all
    end
  end
end
