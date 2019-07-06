class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all 
        binding.pry
        erb :'/tweets/index'
    end 
end
