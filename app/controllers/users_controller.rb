require 'pry'

class UsersController < ApplicationController

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :'users/login'
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :'users/signup'
  end

  get "/failure" do
		erb :failure
	end

  post '/signup' do


    if params[:email].empty? || params[:username].empty? || params[:password].empty?

      redirect "/signup"
    else
      user = User.new(:email => params[:email],:username => params[:username], :password => params[:password])
      user.save
	 		session[:user_id] = user.id
      # binding.pry
	 		redirect "/tweets"
		end
  end

  post "/login" do
  #your code here!

    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
      else
        redirect "/login"
      end
  end


	get "/logout" do
    if Helpers.is_logged_in?(session)

		    session.clear
		    redirect "/login"
    else
        redirect "/"
    end
	end

end
