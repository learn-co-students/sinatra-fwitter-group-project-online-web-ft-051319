class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if user.save
      redirect '/tweets'
    else
      redirect '/'
    end
  end
  
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
