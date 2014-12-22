require 'rails_helper'
require 'rake'

describe 'pierre_et_vacances namespace rake task' do
  before :all do
    Rake.application.rake_require 'tasks/pierre_et_vacances'
    Rake::Task.define_task(:environment)
  end

  describe 'pierre_et_vacances:import' do
    let :run_rake_task do
      Rake::Task['pierre_et_vacances:import'].reenable
      Rake.application.invoke_task 'pierre_et_vacances:import'
    end

    it 'tells the P&V Importer to import' do
      expect(PierreEtVacances::Importer).to receive(:import)
      run_rake_task
    end
  end
end
