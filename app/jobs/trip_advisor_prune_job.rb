# frozen_string_literal: true

# Removes old TripAdvisor properties.
class TripAdvisorPruneJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    TripAdvisorProperty
      .where("updated_at < ?", Time.current - 10.days)
      .find_each { |prop| prop.destroy }
  end
end
