module Backstage
  class BackstageController < Backstage::ApplicationController
    def dashboard
      @companies = current_user.companies.last(5)
      @subscribes = current_user.subscribes.last(5)
    end
  end
end
