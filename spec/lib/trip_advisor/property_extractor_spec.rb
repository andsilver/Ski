require 'rails_helper'

module TripAdvisor
  RSpec.describe PropertyExtractor do
    require 'fileutils'

    describe '#extract' do
      let(:subdir_name) { 'listings_delta_yyyymmdd' }
      let(:subdir) { File.join(dir, subdir_name) }
      let(:dir) { File.join(Rails.root.to_s, 'tmp', 'trip_advisor') }
      let(:archive_filename) { 'listings_delta_yyyymmdd.tar.gz' }
      let(:archive_path) { File.join(dir, archive_filename) }
      let(:file1) { File.join(subdir, 'file1') }
      let(:file2) { File.join(subdir, 'file2') }

      before do
        [dir, subdir].each do |d|
          begin
            Dir.mkdir(d)
          rescue Errno::EEXIST
            Rails.logger.warn "#{dir} already exists"
          end
        end

        FileUtils.touch(file1)
        FileUtils.touch(file2)
        Dir.chdir(dir) do
          `tar czf #{archive_filename} #{subdir_name}`
        end
        FileUtils.rm_rf(subdir)
      end

      after do
        FileUtils.rm_rf(dir)
      end

      it 'extracts files' do
        PropertyExtractor.new(path: archive_path).extract

        expect(FileTest.exist?(file1)).to be_truthy
        expect(FileTest.exist?(file2)).to be_truthy
      end

      it 'yields the path of each file' do
        yielded = []

        PropertyExtractor.new(path: archive_path).extract do |extracted|
          yielded << extracted
        end

        expect(yielded).to eq [file1, file2]
      end
    end
  end
end
