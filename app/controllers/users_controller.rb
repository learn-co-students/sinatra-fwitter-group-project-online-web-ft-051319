class UsersController < ApplicationController
  get '/login' do
    erb :'users/login'
  end
  post '/login' do 
    redirect '/account'
  end
  

end
