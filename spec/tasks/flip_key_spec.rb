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
end
