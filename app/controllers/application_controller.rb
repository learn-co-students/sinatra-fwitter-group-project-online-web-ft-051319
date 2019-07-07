require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #important for sessions to work
    set :session_secret, "secret"
  end

  get '/' do
    "Welcome to Fwitter"
  end



end
