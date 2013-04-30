class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin
  end

  def password
    if params[:password][:pass] == ''
      redirect_to tasks_path
    else
      flash[:warning] = 'Incorrect password.'
      redirect_to '/home'
    end  
  end
end
