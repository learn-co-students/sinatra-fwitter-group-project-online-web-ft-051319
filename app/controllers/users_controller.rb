class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    if params[:username] == ''|| params[:password] == ''|| params[:email] == ''
      redirect '/signup'
    else User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect '/tweets'
    end
  end
  
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
