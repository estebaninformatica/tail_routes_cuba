require "cuba"
require "cuba/safe"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

names_routes = { 
    "operador_prestador"   => ".../log/development.log", 
    "reservas_middle"      => ".../log/development.log"
  }


Cuba.define do
  on get do

    names_routes.each do |key, value|
      on key.to_s do 
        res.write IO.popen(['tail',"-100" ,value]).readlines.join("<br>")
      end
    end
 
    on root do
      res.write names_routes
    end

  end
end
