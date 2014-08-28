require 'xmlsimple'

module FlipKey
  class MessageSender
    def initialize(params)
      @params = params
    end

    def send_message
    end

    def xml
      <<-xml
      <inquiry>
        <header>
          <source>FK</source>
        </header>
        <data>
          <request_date>#{DateTime.now}</request_date>
          <name>#{@params[:name].encode(xml: :text)}</name>
          <total_guests>#{@params[:guests]}</total_guests>
          <check_in>#{@params[:check_in]}</check_in>
          <check_out>#{@params[:check_out]}</check_out>
          <comment><![CDATA[#{@params[:comment]}]]></comment>
          <property_id>#{@params[:property_id]}</property_id>
          <email>#{@params[:email].encode(xml: :text)}</email>
          <phone_number>#{@params[:phone_number].encode(xml: :text)}</phone_number>
          <newsletter_opt_in>0</newsletter_opt_in>
          <user_ip>#{@params[:user_ip]}</user_ip>
          <point_of_sale>mychaletfinder.com</point_of_sale>
          <utm_medium>csynd</utm_medium>
          <utm_source>mychaletfinder</utm_source>
          <utm_campaign><![CDATA[Host&Post]]></utm_campaign>
        </data>
      </inquiry>
      xml
    end
  end
end
