require 'sinatra/base'
require "sinatra/json"
require "sinatra/namespace"
require "sinatra/reloader"

class HomeWizardApiApp < Sinatra::Base
  namespace '/12345' do
    get '/telist' do
      # id{int}, name{string}, lastvalue{double}, favorite{yes/no}
      response = {
        :status => "ok",
        :response => [
          {
            :id => 1,
            :name => "thermo1",
            :temperature => 9.8,
            :humidity => 51.2,
            :channel => 1,
            :favorite => "yes",
            :maxTemperature => 50,
            :minTemperature => 20,
            :maxHumidity => 20,
            :minHumidity => 40,
            :maxTemperatureTime => "12:40",
            :minTemperatureTime => "20:00",
            :maxHumidityTime => "15:50",
            :minHumidityTime => "20:00"
          }
        ]
      }
      json response
    end


    # energy
    #   #id{int}, name{string}, lastvalue{double}, favorite{yes/no}
    get "/enlist" do
      response = {
        :status =>  "ok",
        :response => [
          {
            :id =>  1,
            :name =>  "house",
            :current =>  2040,
            :dayTotal =>  10,
            :maxCurrent =>  104,
            :maxCurrentTime =>  "12:12",
            :minCurrent =>  0,
            :minCurrentTime =>  "0:00",
            :favorite =>  "yes"
          }
        ]
      }
      json response
    end

    # switch
    #id{int}, name{string}, status{on/off},dimmer{yes/no}, favorite{yes/no}
    get "/swlist" do
      response = {
        :status => "ok",
        :response => [
          {
            :id => 1,
            :name => "switch1",
            :status => "off",
            :dimmer => 12.1,
            :favorite => "yes",
            :dimmer => "yes",
            :dimlevel => 20
          },
          {
            :id => 2,
            :name => "switch2",
            :status => "on",
            :dimmer => 22.2,
            :favorite => "no",
            :dimmer => "no",
            :dimlevel => 50
          }
        ]
      }
      json response
    end

    # groups aka scenes
    get "/gplist" do
      response = {
        :status => "ok",
        :response => [
          { :id => 1, :name => "group1", :favorite => "yes" },
          { :id => 2, :name => "group2", :favorite => "no"  }
        ]
      }
      json response
    end

    # # Switch functions

    namespace '/sw' do
      get "/learn" do
        response = {
          :status => "ok",
          :response => {
            :code => "03A13760"
          }
        }
        json response
      end

      get "/get/*/codes" do
        response = {
          :status => "ok",
          :response => [
            "123",
            "456",
            "789"
          ]
        }
        json response
      end
    end

    get "/*/get/*/timers" do
      response = {
        :status => "ok",
        :response => [
          { :id => 1, :active => "yes", :action => "on",  :trigger => "time",    :time => "18:00", :days => [0, 1, 2, 3, 4, 5, 6] },
          { :id => 2, :active => "yes", :action => "off", :trigger => "sunset",  :time => "+120",  :days => [0, 6]                },
          { :id => 3, :active => "no",  :action => "on",  :trigger => "sunrise", :time => "-120",  :days => [2, 3, 4, 5, 6]       }
        ]
      }

      json response
    end

    i = 0;
    get "/*/add/*" do
      i += 1
      response = {
        :status => "ok",
        :response => {
          :id => "#{i}"
        }
      }
      json response
    end

    # # Scene functions
    namespace '/gp' do
      get "/get/*/switches" do
        response = {
          :status => "ok",
          :response => [
            {
              :id => 1,
              :name => "switch1",
              :onstatus => 1,
              :offstatus => 15,
              :dimmer => "yes"
            },
            {
              :id => 2,
              :name => "switch2",
              :onstatus => -1,
              :offstatus => -1,
              :dimmer => "no"
            },
            {
              :id => 3,
              :name => "switch3",
              :onstatus => 0,
              :offstatus => 55,
              :dimmer => "yes"
            }
          ]
        }
        json response
      end
    end

    # # graph functions
    get "/get-status" do
      response = {
        :status => "ok",
        :response => {
          :switches => [
            { :id => 1, :status => "on", :dimmer => "yes", :dimLevel => 100 },
            { :id => 2, :status => "on"  },
            { :id => 3, :status => "off" }
          ],
          :scenes => [
            { :id => 1, :status => "on" },
            { :id => 2, :status => "on" },
            { :id => 3, :status => "on" }
          ],
          :thermometers => [
            { :id => 1, :humidity => 60.0, :temperature => 1.8  },
            { :id => 2, :humidity => 34.0, :temperature => 23.1 }
          ],
          :energymeters => [
            { :id => 1, :current => 40.0 },
            { :id => 2, :current => 10.0 }
          ]
        }
      }
      json response
    end

    namespace '/te' do
      namespace '/graph' do
        get "/*/week" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-06-25 11:30", :temperature => 26.7, :humidity => 63 },
              { :timestamp => "2011-06-26 11:30", :temperature => 26.7, :humidity => 13 },
              { :timestamp => "2011-06-27 11:30", :temperature => 16.7, :humidity => 20 },
              { :timestamp => "2011-06-28 11:30", :temperature => 36.7, :humidity => 30 },
              { :timestamp => "2011-06-29 11:30", :temperature => 20.7, :humidity => 40 },
              { :timestamp => "2011-06-30 11:30", :temperature => 20.7, :humidity => 50 },
              { :timestamp => "2011-07-01 11:30", :temperature => 21.7, :humidity => 60 },
              { :timestamp => "2011-07-02 11:30", :temperature => 25.5, :humidity => 55 },
              { :timestamp => "2011-07-03 11:30", :temperature => 12.7, :humidity => 52 },
              { :timestamp => "2011-07-04 11:30", :temperature => 17.7, :humidity => 83 },
              { :timestamp => "2011-07-05 11:30", :temperature => 23.0, :humidity => 51 }
            ]
          }
          json response
        end
        get "/*/day" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-07-10 00:00", :temprature => 26.7,  :humidity => 23 },
              { :timestamp => "2011-07-10 01:00", :temprature => 22.7,  :humidity => 43 },
              { :timestamp => "2011-07-10 02:00", :temprature => 23.7,  :humidity => 23 },
              { :timestamp => "2011-07-10 03:00", :temprature => -25.7, :humidity => 53 },
              { :timestamp => "2011-07-10 04:00", :temprature => 21.7,  :humidity => 63 },
              { :timestamp => "2011-07-10 05:00", :temprature => 22.7,  :humidity => 73 },
              { :timestamp => "2011-07-10 06:00", :temprature => 22.7,  :humidity => 13 },
              { :timestamp => "2011-07-10 07:00", :temprature => 22.7,  :humidity => 33 },
              { :timestamp => "2011-07-10 08:00", :temprature => 22.7,  :humidity => 4  },
              { :timestamp => "2011-07-10 09:00", :temprature => 23.7,  :humidity => 13 },
              { :timestamp => "2011-07-10 10:00", :temprature => 23.7,  :humidity => 43 },
              { :timestamp => "2011-07-10 11:00", :temprature => 24.7,  :humidity => 73 },
              { :timestamp => "2011-07-10 12:00", :temprature => 25.7,  :humidity => 73 },
              { :timestamp => "2011-07-10 13:00", :temprature => 26.7,  :humidity => 73 },
              { :timestamp => "2011-07-10 14:00", :temprature => 26.7,  :humidity => 83 },
              { :timestamp => "2011-07-10 15:00", :temprature => 27.7,  :humidity => 33 },
              { :timestamp => "2011-07-10 16:00", :temprature => 28.7,  :humidity => 43 },
              { :timestamp => "2011-07-10 17:00", :temprature => 23.7,  :humidity => 63 },
              { :timestamp => "2011-07-10 18:00", :temprature => 23.7,  :humidity => 13 },
              { :timestamp => "2011-07-10 19:00", :temprature => 24.7,  :humidity => 23 },
              { :timestamp => "2011-07-10 20:00", :temprature => 21.7,  :humidity => 43 },
              { :timestamp => "2011-07-10 21:00", :temprature => 21.7,  :humidity => 63 },
              { :timestamp => "2011-07-10 22:00", :temprature => 23.7,  :humidity => 68 },
              { :timestamp => "2011-07-10 23:00", :temprature => 24.7,  :humidity => 69 },
              { :timestamp => "2011-07-11 00:00", :temprature => 26.7,  :humidity => 23 }
            ]
          }
          json response
        end

        get "/*/year" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-01-01 12:00", :maxTemperature => 26.7, :maxHumidity => 63, :minTemperature => 16.7, :minHumidity => 13 },
              { :timestamp => "2011-02-01 12:00", :maxTemperature => 26.7, :maxHumidity => 13, :minTemperature => 16.7, :minHumidity => 10 },
              { :timestamp => "2011-03-01 12:00", :maxTemperature => 16.7, :maxHumidity => 20, :minTemperature => 6.7,  :minHumidity => 10 },
              { :timestamp => "2011-04-01 12:00", :maxTemperature => 36.7, :maxHumidity => 30, :minTemperature => 6.7,  :minHumidity => 23 },
              { :timestamp => "2011-05-01 12:00", :maxTemperature => 20.7, :maxHumidity => 40, :minTemperature => 4.7,  :minHumidity => 13 },
              { :timestamp => "2011-06-01 12:00", :maxTemperature => 20.7, :maxHumidity => 50, :minTemperature => 16.7, :minHumidity => 33 },
              { :timestamp => "2011-07-01 12:00", :maxTemperature => 21.7, :maxHumidity => 60, :minTemperature => 16.7, :minHumidity => 43 },
              { :timestamp => "2011-08-01 12:00", :maxTemperature => 25.5, :maxHumidity => 55, :minTemperature => 6.7,  :minHumidity => 13 },
              { :timestamp => "2011-09-01 12:00", :maxTemperature => 12.7, :maxHumidity => 52, :minTemperature => 6.7,  :minHumidity => 33 },
              { :timestamp => "2011-10-01 12:00", :maxTemperature => 17.7, :maxHumidity => 83, :minTemperature => 14.7, :minHumidity => 53 },
              { :timestamp => "2011-11-01 12:00", :maxTemperature => 23.0, :maxHumidity => 51, :minTemperature => 15.7, :minHumidity => 13 },
              { :timestamp => "2011-12-01 12:00", :maxTemperature => 23.0, :maxHumidity => 51, :minTemperature => 22.7, :minHumidity => 33 }
            ]
          }
          json response
        end
      end
    end

    namespace '/en' do
      namespace '/graph' do
        get "/*/week/power" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-06-25 11:30", :power => 100 },
              { :timestamp => "2011-06-26 11:30", :power => 550 },
              { :timestamp => "2011-06-27 11:30", :power => 230 },
              { :timestamp => "2011-06-28 11:30", :power => 163 },
              { :timestamp => "2011-06-29 11:30", :power => 133 },
              { :timestamp => "2011-06-30 11:30", :power => 522 },
              { :timestamp => "2011-07-01 11:30", :power => 113 },
              { :timestamp => "2011-07-02 11:30", :power => 245 },
              { :timestamp => "2011-07-03 11:30", :power => 333 },
              { :timestamp => "2011-07-04 11:30", :power => 400 },
              { :timestamp => "2011-07-05 11:30", :power => 200 }
            ]
          }
          json response
        end

        get "/*/week/consumption" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-06-25 11:30", :consumption => 100 },
              { :timestamp => "2011-06-26 11:30", :consumption => 550 },
              { :timestamp => "2011-06-27 11:30", :consumption => 230 },
              { :timestamp => "2011-06-28 11:30", :consumption => 163 },
              { :timestamp => "2011-06-29 11:30", :consumption => 133 },
              { :timestamp => "2011-06-30 11:30", :consumption => 522 },
              { :timestamp => "2011-07-01 11:30", :consumption => 113 },
              { :timestamp => "2011-07-02 11:30", :consumption => 245 },
              { :timestamp => "2011-07-03 11:30", :consumption => 333 },
              { :timestamp => "2011-07-04 11:30", :consumption => 400 },
              { :timestamp => "2011-07-05 11:30", :consumption => 200 }
            ]
          }
          json response
        end

        get "/*/day/*" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-07-09 00:00", :power => 26.7  },
              { :timestamp => "2011-07-09 01:00", :power => 55.7  },
              { :timestamp => "2011-07-09 02:00", :power => 322.7 },
              { :timestamp => "2011-07-07 03:00", :power => 116.7 },
              { :timestamp => "2011-07-09 04:00", :power => 23.7  },
              { :timestamp => "2011-07-09 05:00", :power => 212.7 },
              { :timestamp => "2011-07-09 06:00", :power => 4.7   },
              { :timestamp => "2011-07-09 07:00", :power => 56.7  },
              { :timestamp => "2011-07-09 08:00", :power => 36.7  },
              { :timestamp => "2011-07-09 09:00", :power => 16.7  },
              { :timestamp => "2011-07-09 10:00", :power => 226.7 },
              { :timestamp => "2011-07-09 11:00", :power => 626.7 },
              { :timestamp => "2011-07-09 12:00", :power => 326.7 },
              { :timestamp => "2011-07-09 13:00", :power => 526.7 },
              { :timestamp => "2011-07-09 14:00", :power => 426.7 },
              { :timestamp => "2011-07-09 15:00", :power => 226.7 },
              { :timestamp => "2011-07-09 16:00", :power => 326.7 },
              { :timestamp => "2011-07-09 17:00", :power => 426.7 },
              { :timestamp => "2011-07-09 18:00", :power => 626.7 },
              { :timestamp => "2011-07-09 19:00", :power => 126.7 },
              { :timestamp => "2011-07-09 20:00", :power => 126.7 },
              { :timestamp => "2011-07-09 21:00", :power => 326.7 },
              { :timestamp => "2011-07-09 22:00", :power => 326.7 },
              { :timestamp => "2011-07-09 23:00", :power => 426.7 },
              { :timestamp => "2011-07-10 00:00", :power => 526.7 }
            ]
          }
          json response
        end

        get "/*/year/power" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-01-01 12:00", :power => 451 },
              { :timestamp => "2011-02-01 12:00", :power => 151 },
              { :timestamp => "2011-03-01 12:00", :power => 251 },
              { :timestamp => "2011-04-01 12:00", :power => 451 },
              { :timestamp => "2011-05-01 12:00", :power => 151 },
              { :timestamp => "2011-06-01 12:00", :power => 251 },
              { :timestamp => "2011-07-01 12:00", :power => 351 },
              { :timestamp => "2011-08-01 12:00", :power => 551 },
              { :timestamp => "2011-09-01 12:00", :power => 351 },
              { :timestamp => "2011-10-01 12:00", :power => 451 },
              { :timestamp => "2011-11-01 12:00", :power => 251 },
              { :timestamp => "2011-12-01 12:00", :power => 351 }
            ]
          }
          json response
        end

        get "/*/year/consumption" do
          response = {
            :status => "ok",
            :response => [
              { :timestamp => "2011-01-01 12:00", :consumption => 451 },
              { :timestamp => "2011-02-01 12:00", :consumption => 151 },
              { :timestamp => "2011-03-01 12:00", :consumption => 251 },
              { :timestamp => "2011-04-01 12:00", :consumption => 451 },
              { :timestamp => "2011-05-01 12:00", :consumption => 151 },
              { :timestamp => "2011-06-01 12:00", :consumption => 251 },
              { :timestamp => "2011-07-01 12:00", :consumption => 351 },
              { :timestamp => "2011-08-01 12:00", :consumption => 551 },
              { :timestamp => "2011-09-01 12:00", :consumption => 351 },
              { :timestamp => "2011-10-01 12:00", :consumption => 451 },
              { :timestamp => "2011-11-01 12:00", :consumption => 251 },
              { :timestamp => "2011-12-01 12:00", :consumption => 351 }
            ]
          }
          json response
        end
      end
    end

    get "/*" do
      response = {
        :status => "ok"
      }
      json response
    end
  end

  # # general routes

  get "/handshake/*" do
    response = {
      :status => "ok",
      :response => {
        :homewizard => "yes",
        :version => "0.1a"
      }
    }
    json response
  end
end
