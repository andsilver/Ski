module Interhome
  class CancellationConditionsResponse < Response
    def conditions
      conds = {}
      cancellation_conditions.each do |i|
        conds[i["DaysBeforeDeparte"][0]] = i["Percentage"][0]
      end
      conds
    end

    def cancellation_conditions
      result["CancellationConditions"][0]["CancellationConditionItem"]
    end

    def result
      response["CancellationConditionsResult"][0]
    end

    def response
      @data["Body"][0]["CancellationConditionsResponse"][0]
    end
  end
end
