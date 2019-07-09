class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = current_user

            erb :'/tweets/home'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect '/tweets/new'
        else
            @tweet = current_user.tweets.create(content: params[:content])
            id = @tweet.id
            # current_user.tweets << @tweet
            if @tweet.save
                erb :'/tweets/show'
            else
                redirect '/tweets/new'
            end
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        
        if !logged_in?
            redirect '/login'
        elsif current_user.id != @tweet.user_id
            redirect '/tweets'
        else
            erb :'/tweets/show'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])

        if !logged_in?
            redirect '/login'
        elsif current_user.id != @tweet.user_id
            redirect '/tweets'
        else
            erb :'/tweets/edit'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params[:content])

        erb :'/tweets/show'
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        
        if !logged_in? 
            redirect '/login' 
        elsif current_user.id != @tweet.user_id
            redirect '/tweets'
        else
            @tweet.delete
            redirect '/tweets'
        end
    end
end
