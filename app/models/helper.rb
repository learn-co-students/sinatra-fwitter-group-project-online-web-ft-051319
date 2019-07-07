class Helpers < Sinatra::Base

  def self.is_logged_in?(session)
    if !!session[:user_id]
      @error=""
      true
    else
      @error="Please log in to access tweets"
      false
    end
  end


end
