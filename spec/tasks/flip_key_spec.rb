require 'rails_helper'
require 'rake'

describe 'flip_key namespace rake task' do
  before :all do
    Rake.application.rake_require 'tasks/flip_key'
    Rake::Task.define_task(:environment)
  end

  describe 'flip_key:import' do
    let :run_rake_task do
      Rake::Task['flip_key:import'].reenable
      Rake.application.invoke_task 'flip_key:import'
    end

    it 'creates a new importer' do
      expect(FlipKey::Importer).to receive(:new).and_return(double(FlipKey::Importer).as_null_object)
      run_rake_task
    end

    it 'tells the importer to import' do
      importer = double(FlipKey::Importer)
      expect(FlipKey::Importer).to receive(:new).and_return(importer)
      expect(importer).to receive(:import)
      run_rake_task
    end
  end

  describe 'flip_key:destroy_stale_properties' do
    let :run_rake_task do
      Rake::Task['flip_key:destroy_stale_properties'].reenable
      Rake.application.invoke_task 'flip_key:destroy_stale_properties'
    end

    it 'destroys stale properties' do
      stale = FactoryGirl.create(:flip_key_property, updated_at: Time.zone.now - (1.week + 1.second))
      still_fresh = FactoryGirl.create(:flip_key_property, updated_at: Time.zone.now - 6.days)
      run_rake_task
      expect(FlipKeyProperty.find_by_id(stale.id)).to be_nil
      expect(FlipKeyProperty.find_by_id(still_fresh.id)).to be
    end
  end
end
