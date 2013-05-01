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

  API_URL = "http://10.1.10.78/timeclock/timeclock_api.php"
  def punch_in (username, password)
    response = HTTParty.get("#{API_URL}?operation=100&username=#{username}&password=#{password}")
    #check for failure?
  end

   def punch_out (username, password)
    response = HTTParty.get("#{API_URL}?operation=101&username=#{username}&password=#{password}")
     #check for failure?
  end

   def fetch_elves
     response =  HTTParty.get("#{API_URL}?operation=102")
     JSON.parse(response.parsed_response)
   end

   def fetch_in_out (username)
     response = HTTParty.get("#{API_URL}?operation=103&username=#{username}")
     JSON.parse(response.parsed_response)
   end
end
