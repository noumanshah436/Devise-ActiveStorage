class ApplicationController < ActionController::Base

  def after_sign_in_path_for(_resource)
     home_index_url
  end
end
