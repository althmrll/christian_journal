class PagesController < ApplicationController
  skip_before_action :verify_access, only: [ :home ]
  def home
  end
end
