class UsersController < ApplicationController
  # Displays signup if user not logged in.

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  #Submits signup as long as information isn't blank and saves user_id to hash.

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  # Loads login page if not logged in.

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

 # Submits login information and authenticates username with password then redirects to tweets.

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect '/tweets'
    else
	    redirect '/login'
    end
	end

  # Logs out and destroys session.

  get '/logout' do
    if logged_in?
      session.destroy
		  redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
