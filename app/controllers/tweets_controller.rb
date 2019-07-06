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

    patch '/tweets/:id' do 
        if is_logged_in?
            if params[:content] == ""
                redirect "/tweets/#{params[:id]}/edit"
            else 
                @tweet = Tweet.find(params[:id])
                
                if @tweet.user == current_user
                
                    @tweet.update(content: params[:content])
                    redirect "/tweets/#{params[:id]}"
                else 
                    redirect '/tweets'
                end 
            end 
        else 
            redirect '/login'
        end 
    end 

    delete '/tweets/:id/delete' do
       @tweet = Tweet.find(params[:id])
        if is_logged_in? && current_user.tweets.include?(@tweet)
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/login'
        end
    end 

    
end
