require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "test"
  end
 
  get '/' do
    erb :homepage
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    username = params[:username]
    email = params[:email]
    pass = params[:password]

    if username.empty? || email.empty? || pass.empty?
      redirect "/signup"
    else
      @user = User.create(username: username, email: email, password: pass)
      session[:user_id] = @user.id

      redirect "/tweets"
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      erb :"/users/logout"
    end
    redirect "/login"
  end

  post '/logout' do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if logged_in?
      if params[:content].empty?
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get "/tweets/:id" do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if logged_in?
      if params[:content].empty?
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect "/tweets"
        end
      end
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
      # User.find_by_id(session[:user_id])
    end
  end

end
