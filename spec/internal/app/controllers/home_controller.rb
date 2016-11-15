class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    render_plain_text 'OK'
  end
end
