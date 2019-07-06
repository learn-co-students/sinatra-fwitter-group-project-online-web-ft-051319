class TweetsController < ApplicationController

    get '/tweets' do
      if is_logged_in?
        @tweets = Tweet.all 
        erb :'/tweets/index'
      else 
        redirect '/login'
      end 
    end 

    get '/tweets/new' do 
        if is_logged_in?
            erb :'/tweets/new'
        else 
            redirect '/login'
        end 
    end 

    post '/tweets' do 
        # @tweet = Tweet.new(content: params[:content])
        # @tweet.user = current_user 
        # redirect '/tweets/#{@tweet.id}'
        if params[:content] != ""  
            tweet = Tweet.new(content: params[:content])
            tweet.user_id = session[:user_id]
            tweet.save
      
            redirect to '/tweets'
          else
            redirect to '/tweets/new'
          end
    end 

    get '/tweets/:id' do 
        if is_logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else 
            redirect '/login'
        end 
    end 

    get '/tweets/:id/edit' do
        if is_logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'/tweets/edit'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end
end
