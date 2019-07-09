require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if session[:user_id]
      redirect '/tweets'
    end
    erb :'users/signup'
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do 
    # binding.pry
    if session[:user_id]
      @user = User.find(session[:user_id])
      # session[:user_id] = @user.id
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
    # erb :'tweets/tweets'
  end

  get '/login' do 
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      redirect "/login"
    end
  end

  get '/logout' do 
    # if session[:user_id]
    #   session.clear
    #   redirect "/login"
    # else
    #   redirect '/'
    # end

      session.clear
      redirect "/login"
  end

  # post '/logout' do 
  #   session.clear
  #   redirect "/login"
  # end

  get '/tweets/new' do 
    if session[:user_id]
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do 
    # binding.pry
    if params[:content] != ""
      @tweet = Tweet.create(params)
      @user = User.find(session[:user_id])
      # @tweet.user = @user
      @user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do 
    # @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
    if session[:user_id]
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do 
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      @user = User.find(session[:user_id])
      if @tweet && @tweet.user == @user
        erb :'tweets/edit_tweet'
      end
    else 
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    # @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      # @tweet.update(params)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    # binding.pry
    @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
    # @user.tweets.include?(@tweet)
    if @tweet == nil 
      redirect '/tweets'
    elsif @tweet.user == @user
      @tweet.destroy
      # Tweet.destroy(params[:id])
      redirect '/tweets'
    else
      redirect '/login'
    end

    # @user = User.find(session[:user_id])
    # @tweet = Tweet.find(params[:id])
    # if @user && @user.tweets.include?(@tweet)
    #   erb :'tweets/edit_tweet'
    # end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
