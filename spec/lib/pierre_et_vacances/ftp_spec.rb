require 'spec_helper'

describe PierreEtVacances::FTP do
  describe 'most_recent_file' do
    it 'returns the most recent file, based on date in filename' do
      list = ['abc-13Dec2013.xml', 'abc-02Feb2014.xml', 'abc-10Jun2013.xml']
      expect(PierreEtVacances::FTP.most_recent_file(list)).to eq 'abc-02Feb2014.xml'
    end
  end
end
