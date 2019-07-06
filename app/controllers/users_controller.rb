class UsersController < ApplicationController

    get '/signup' do 
      if !is_logged_in? 
        erb :'/users/signup'
      else 
            redirect '/tweets'
      end 
    end 
    
      post '/signup' do
        # binding.pry
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else        
            @current_user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @current_user.save
            session[:user_id] = @current_user.id
            # binding.pry
            redirect to '/tweets'
        end
      end 
    
      get '/login' do 
        if !is_logged_in? 
            erb :'/users/login'
        else 
            redirect '/tweets'
        end 
      end 

    
      post '/login' do 
        # binding.pry
        @current_user = User.find_by(username: params[:username])
        if @current_user && @current_user.authenticate(params[:password])
          session[:user_id] = @current_user.id 
          redirect to '/tweets'
          binding.pry
        else 
          redirect '/signup'
        end 
      end 

      get '/logout' do 
        if is_logged_in? 
          session.clear 
          redirect '/login'
        else 
          redirect '/'
        end 
      end 

      get '/users/:id' do 
        @user = User.find(params[:id])
        erb :'/users/show'
      end 

end
