class UsersController < ApplicationController

#CREATE
  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end
  
  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])
    
    if is_logged_in?
      redirect '/tweets'
      
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
      
    else
      redirect '/login'
    end
  end

#READ

#UPDATE

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

#DELETE

end
