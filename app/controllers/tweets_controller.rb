class TweetsController < ApplicationController

  get '/tweets' do

    if !!session[:user_id]
      @user=User.find(session[:user_id])
      @tweets=Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if !!session[:user_id]
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet=Tweet.create(params)
      @tweet.user_id=session[:user_id]
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !!session[:user_id]
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !!session[:user_id]
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet=Tweet.find(params[:id])
    if params[:content]!=""
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @user=User.find(session[:user_id])
    @tweet=Tweet.find(params[:id])
    if @tweet.user==@user
      @tweet.delete
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

end
