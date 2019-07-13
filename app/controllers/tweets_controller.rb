class TweetsController < ApplicationController

  get '/tweets/new' do
    if Helpers.is_logged_in? (session)
      erb :'tweets/new'
    else
      redirect '/login'
    end

  end

  delete '/tweets/:id' do
  #  binding.pry
    tweet=Tweet.find(params[:id])
    if Helpers.is_logged_in?(session)
      if Helpers.current_user(session).id != tweet.user_id
         redirect '/tweets'
       end

      tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  patch "/tweets/:id" do
    tweetnew= Tweet.find(params[:id])

    @content=params[:content]
    @user_id=params[:user_id]

    if @content.empty?
      redirect "/tweets/#{tweetnew.id}/edit"
    end
    tweetnew.update({:content => @content, :user_id=>@user_id})

    redirect to "/tweets/#{tweetnew.id}"
  end

  get '/tweets/:id/edit' do
  #  binding.pry
    if Helpers.is_logged_in?(session)
      @tweet=Tweet.find(params[:id])
      curruser=Helpers.current_user(session)

      if Helpers.current_user(session).id != @tweet.user_id
      #     binding.pry
          redirect '/tweets'
      end
      # binding.pry
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
  #  binding.pry
    if Helpers.is_logged_in?(session)
      @tweet=Tweet.find(params[:id])
  #    binding.pry
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end


  get '/tweets' do
    # binding.pry
      if Helpers.is_logged_in? (session)
        @tweets = Tweet.all
        erb :'tweets/index'
      else
        redirect '/login'
      end
  end

  get '/users/:id' do
    @id=params[:id]
    @tweets=Tweet.where("user_id=#{@id}")
    erb :'tweets/index'

  end

  post '/tweets' do

    if  !(params[:content].empty?)
      tweetnew=Tweet.create(content: params[:content], user_id: session[:user_id])
    else
      redirect '/tweets/new'
    end

  end


  # helpers do
  #   def logged_in?
  #     !!session[:user_id]
  #   end
  #
  #   def current_user
  #     User.find(session[:user_id])
  #   end
  # end

end
