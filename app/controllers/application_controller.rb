class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin
  end

  def pass
    if params[:password][:pass] == ''
      redirect_to tasks_path
    else
      flash[:warning] = 'Incorrect password.'
      redirect_to '/home'
    end  
  end

  API_URL = "http://10.1.10.78/timeclock/timeclock_api.php"

  #Translates Elf.names to the ModBot TimeClock's identifiers
  CLOCK_NAMES = {"Sawyer Bernath" => "Sawyer Bernath",
    "Kristin Yen" => "Kristin Yen",
    "Chris Borke" => "christopherborke",
    "Keegan Ridgley" => "Keegan Ridgley",
    "Karl Stokely" => "KStokley",
    "Ying Her" => "yingher",
    "Logan Priess" => "Logan Priess",
    "Joe Ferry" => "Michaelferry",
    "Jenny Chambers" => "JChambers",
    "Michael Kramer" => "Michael Kramer"}

   def fetch_elves
     response =  HTTParty.get("#{API_URL}?operation=102")
     JSON.parse(response.parsed_response)
   end

   def fetch_in_out (username)
     response = HTTParty.get("#{API_URL}?operation=103&username=#{username}")
     JSON.parse(response.parsed_response)
   end
end
