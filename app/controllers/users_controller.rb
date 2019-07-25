class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
    redirect '/tweets'
  end
  
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
