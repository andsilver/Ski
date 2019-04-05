module Interhome
  module AdditionalServicesMixin
    def initialize_additional_services
      @additional_services = []
      if additional_service_items
        additional_service_items.each do |s|
          @additional_services << AdditionalService.new(s)
        end
        @additional_services.each {|s| puts "[#{s.code} - #{s.type}] #{s.description} #{s.amount} #{s.currency} #{s.price_rule_desc}"}
      end
    end

    def on_invoice
      @additional_services.select { |s| s.type == "N1" || s.type == "N2" || s.type == "Y1" }
    end

    def bookable
      @additional_services.select { |s| s.type == "N1" || s.type == "N2" }
    end

    def included
      @additional_services.select { |s| s.type == "Y2" }
    end

    def not_included
      @additional_services.select { |s| s.type == "Y4" }
    end

    def additional_service_items
      additional_services_x[0]["AdditionalServiceItem"]
    end

    def additional_services_x
      result["AdditionalServices"]
    end
  end
end
