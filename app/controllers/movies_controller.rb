class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ["G", "PG" , "PG-13" , "R"] 
    @select = []
    params["remember"] = []
    @val = params[:ratings]
    if !params[:ratings].nil?
      params[:ratings].each do |key , value|
        @select << key
        params["#{key}"]=true
      end
    end
    
    @movie = Movie.where(rating: @select)
    if !@movie.empty?
      @movies = @movie.order(params[:sort])
    else
      @movies = Movie.order(params[:sort])
    end 
    if params[:sort] == "title"
      @class_t = "hilite"      
    elsif params[:sort] == "release_date"
      @class_r = "hilite"      
    else 
      @class_t = ""
      @class_r = ""
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
