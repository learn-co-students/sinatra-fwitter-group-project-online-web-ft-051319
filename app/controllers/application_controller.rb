require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "my_application_secret"
    set :views, 'app/views'
  end
  
  get '/' do
    erb :home
  end
  
  helpers do
    def is_logged_in?
      !!session[:user_id]
    end
    
    def current_user
      @current_user ||= User.find(session[:user_id])
    end
  end
  
end