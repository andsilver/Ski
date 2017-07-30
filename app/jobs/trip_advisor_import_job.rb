class TripAdvisorImportJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    importer = TripAdvisor::Importer.new(
      sftp_details: TripAdvisor::SFTPDetails.default
    )
    importer.import_locations
    importer.import_properties
  end
end
