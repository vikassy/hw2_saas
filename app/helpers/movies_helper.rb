module MoviesHelper

  #Stores the address of ther given url
  def store_url
    session[:url] =  request.fullpath
  end
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  #Send to particular URl 
  def send_user
    session[:url]
    session.delete(:url)
  end
  
end
