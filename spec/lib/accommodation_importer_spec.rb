describe AccommodationImporter do
  Accommodation = Struct.new(:dummy)

  describe '#import' do
    it 'runs setup' do
      i = AccommodationImporter.new
      i.should_receive(:setup)
      i.import []
    end
  end

  describe '#setup' do
    it 'finds the Euro currency and user by email' do
      i = AccommodationImporter.new
      i.stub(:user_email).and_return('somebody@example.org')
      User.should_receive(:find_by).with(email: 'somebody@example.org').and_return(true)
      Currency.should_receive(:find_by).with(code: 'EUR').and_return(true)
      i.setup
    end
  end

  describe '#cleanup' do
    it 'deletes old adverts' do
      i = AccommodationImporter.new
      i.should_receive(:delete_old_adverts)
      i.stub(:setup)
      i.stub(:destroy_all)
      i.user = User.new
      i.cleanup
    end

    it 'destroys all accommodations' do
      i = AccommodationImporter.new
      i.should_receive(:destroy_all)
      i.stub(:setup)
      i.stub(:delete_old_adverts)
      i.cleanup
    end
  end

  describe '#destroy_all' do
    it 'destroys all accommodation objects updated before the import began' do
      i = AccommodationImporter.new
      i.stub(:model_class).and_return(Accommodation)
      start_time = Time.now
      i.import_start_time = start_time 
      Accommodation.should_receive(:destroy_all).with(['updated_at < ?', start_time])
      i.destroy_all
    end
  end
end
