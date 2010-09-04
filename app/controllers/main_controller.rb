class MainController < ApplicationController
  def index
    @championships = Championship.find_championships_for_home
  end

  protected

    def authorize
      
    end
end
