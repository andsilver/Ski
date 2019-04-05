module Admin
  class TrackedActionsController < AdminController
    def index
      @tracked_actions = TrackedAction.order("created_at DESC")
    end
  end
end
