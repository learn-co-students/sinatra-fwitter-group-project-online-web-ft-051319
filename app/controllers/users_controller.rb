class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    user = user.new(username: params[:username], password: params[:password], email: params[:email])
    redirect '/tweets'
  end
  
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
