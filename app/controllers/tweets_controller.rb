class TweetsController < ApplicationController

#CREATE  
  get '/tweets/new' do
    erb :'/tweets/new'
  end
  
  post '/tweets' do
    @tweet = Tweet.create(params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

#READ
  get '/tweets' do
    if is_logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

#UPDATE
  get '/tweets/:id/edit' do
    
  end
  
  patch '/tweets/:id' do
    
  end

#DELETE
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete    
    redirect '/tweets'
  end
  
end
