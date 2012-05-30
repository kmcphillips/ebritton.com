class PreviewController < ApplicationController

  before_filter :authenticate_admin_user!

  def index
    respond_to do |wants|
      wants.js do
        render :text => RDiscount.new(params[:body]).to_html.html_safe
      end
    end
  end

end
