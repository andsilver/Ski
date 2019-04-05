# frozen_string_literal: true

module TripAdvisor
  def self.user
    User.find_by(email: "tripadvisor@mychaletfinder.com")
  end
end
