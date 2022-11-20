module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'application', only: %i[edit update]
  end
end
