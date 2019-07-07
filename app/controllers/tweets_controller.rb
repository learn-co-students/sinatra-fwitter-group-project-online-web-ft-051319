class TweetsController < ApplicationController

#CREATE  
  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    end
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
    
    if is_logged_in?
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

#UPDATE
  get '/tweets/:id/edit' do
    if is_logged_in?
      if @tweet = current_user.tweets.find_by(params[:id])
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    end
  end

#DELETE
  delete '/tweets/:id' do
    if is_logged_in?
      if @tweet = current_user.tweets.find_by(params[:id])
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
end
