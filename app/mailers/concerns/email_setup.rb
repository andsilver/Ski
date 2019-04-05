module EmailSetup
  extend ActiveSupport::Concern

  included do
    after_action :set_mandrill_subaccount
  end

  def set_mandrill_subaccount
    headers["X-MC-Subaccount"] = "MyChaletFinder"
  end
end
