module Backstage
  module Admin
    class ApplicationController < Backstage::ApplicationController
      before_action :authenticate_admin!
    end
  end
end
