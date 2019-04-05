module Interhome
  class AvailabilityResponse < Response
    def unavailable?
      !available?
    end

    def available?
      ok? &&
        start_date == requested(:check_in) &&
        end_date == requested(:check_out) &&
        available_every_day? &&
        check_in_on_first_day? &&
        check_out_on_last_day? &&
        staying_long_enough?
    end

    def available_every_day?
      state.delete("Y").empty?
    end

    def check_in_on_first_day?
      "CI".include? change[0]
    end

    def check_out_on_last_day?
      "CO".include? change[-1]
    end

    def staying_long_enough?
      min_duration = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(minimum_stay[0])
      duration >= min_duration
    end

    def duration
      (Date.parse(end_date) - Date.parse(start_date)).to_i
    end

    def start_date
      result["StartDate"][0]
    end

    def end_date
      result["EndDate"][0]
    end

    def state
      result["State"][0]
    end

    def change
      result["Change"][0]
    end

    def minimum_stay
      result["MinimumStay"][0]
    end

    def result
      response["AvailabilityResult"][0]
    end

    def response
      @data["Body"][0]["AvailabilityResponse"][0]
    end
  end
end
