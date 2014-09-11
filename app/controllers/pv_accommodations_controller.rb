class PvAccommodationsController < ApplicationController
  before_action :admin_required

  layout 'admin'

  def index
    @pv_accommodations = PvAccommodation.all
  end

  def import_accommodations
    importer = PierreEtVacances::AccommodationImporter.new
    ftp = PierreEtVacances::FTP.new
    ftp.get
    importer.import([File.join('pierreetvacances', ftp.xml_filename)])
    redirect_to({action: 'index'}, notice: 'Pierre et Vacances accommodations have been imported.')
  end
end
