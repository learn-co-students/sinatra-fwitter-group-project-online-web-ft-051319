require './config/environment'
require 'sinatra/base'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end 

  
  helpers do 
    def logged_in? 
      !!session[:user_id]
    end 

    def current_user
      User.find(session[:id])
    end 

  end 


end
