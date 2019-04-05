class ExportController < ApplicationController
  before_action :admin_required

  layout "admin"

  CLASSES = %w[Advert AirportDistance Airport
               Category Country Coupon Currency DirectoryAdvert Enquiry Image
               Order OrderLine Page Payment Property PropertyBasePrice
               PropertyVolumeDiscount Resort Role User Website]

  def index
    @classes = CLASSES
  end

  def spreadsheet
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet name: params[:class_name]

    c = Kernel.const_get(params[:class_name])
    records = c.all
    object = c.first

    object.attribute_names.each do |attribute|
      sheet.row(0).concat [attribute]
    end

    row = 1
    records.each do |record|
      record.attribute_names.each do |attribute|
        a = record.send(attribute)
        sheet.row(row).concat [a]
      end
      row += 1
    end

    t = Time.now
    filename = t.strftime("%Y%m%d-%H%M") + "-#{params[:class_name]}.xls"

    blob = StringIO.new("")
    book.write blob
    Mime::Type.register "application/vnd.ms-excel", :xls
    send_data blob.string, type: :xls, filename: filename
  end
end
