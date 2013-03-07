require 'spec_helper'

describe PierreEtVacances::FTP do
  describe 'most_recent_file' do
    it 'returns the most recent file, based on date in filename' do
      list = ['abc-13Dec2013.xml', 'abc-02Feb2014.xml', 'abc-10Jun2013.xml']
      PierreEtVacances::FTP.most_recent_file(list).should == 'abc-02Feb2014.xml'
    end
  end
end
