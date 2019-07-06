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

  get '/signup' do 
    erb :'/users/signup'
  end 

  post '/signup' do 
    @user = User.create(params[:user])
    binding.pry
    session[:user_id] = @user.id
    redirect '/tweets'
  end 

  get '/login' do 
    erb :'/users/login'
  end 

  post '/login' do 
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user_id 
      redirect '/tweets'
    else 
      redirect '/login'
    end 
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
