class PvAccommodationsController < ApplicationController
  before_action :admin_required

  layout 'admin'

  def index
    @pv_accommodations = PvAccommodation.all
  end

  def import_accommodations
    importer = PierreEtVacances::AccommodationImporter.new
    importer.ftp_get
    importer.import([File.join('pierreetvacances', importer.xml_filename)], true)
    redirect_to({action: 'index'}, notice: 'Pierre et Vacances accommodations have been imported.')
  end
end
