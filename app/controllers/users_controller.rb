class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      #making sure that the user cant sign up without these attributes
      redirect '/signup'
    else
      @user=User.create(params)
      session[:user_id]=@user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user=User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id]=user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if !!session[:user_id]
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user=User.find_by_slug(params[:slug])
    @tweets=@user.tweets
    erb :'/tweets/single'
  end



end
