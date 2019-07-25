class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    redirect '/tweets'
  end
  
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
