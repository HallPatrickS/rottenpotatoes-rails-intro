class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    @sort = params[:sort]||session[:sort]
    session[:ratings] = session[:ratings] || {'G'=> '', 'PG'=> '', 'PG'=>'', 'PG-13'=>'','R'=>''}
    @t_param = params[:ratings] || session[:ratings]
    session[:sort] = @sort
    session[:ratings] = @t_param
    @movies = Movie.where(rating: session[:ratings].keys).order(session[:sort])
    if (params[:sort].nil? and !(session[:sort].nil?)) or (params[:ratings].nil? and !(session[:ratings].nil?))
          flash.keep
          redirect_to movies_path(sort: session[:sort],ratings: session[:ratings])
    end
  end
        # @movies = Movie.all
   # @all_ratings = Movie.ratings
    #redirect = false
    
   # if params[:sort]
    #  @sort = params[:sort]
   #   session[:sort_by] = params[:sort]
  #  elsif session[:sort] = params[:sort]
   #   @sort = session[:sort]
      # redirect = true
   # else
    #  @sort = nil
   # end

   # if params[:commit] == "Refresh" and params[:ratings].nil?
    #  @ratings = nil
     # session[:ratings] = nil
   # elsif params[:ratings]
   #   @ratings = params[:ratings]
    #  session[:ratings] = params[:ratings]
   # elsif session[:ratings]
    #  @ratings = session[:ragtings]
      # redirect = true
   # else
    #  @ratings = nil
    #end

   # if redirect
    #  flash.keep
     # redirect_to movies_path :sort_by=>@sort_by, :ratings=>@ratings
   # end

    # @sort = params[:sort] || session[:sort]
    # @ratings = params[:ratings] || session[:ratings]

    # @all_ratings = Movie.ratings

   # if @sort and @ratings
    #  session[:sort] = @sort
     # session[:ratings] = @ratings
      # @movies = Movie.where(rating: @ratings.keys).find(:all, :order => (@sort))
     # @movies = Movie.where(:rating => @ratings.keys).find(:all, :order => (@sort))
      # @movies = Movie.order(@sort.to_sym) # DB order command
   # elsif @ratings
    #  session[:ratings] = @ratings
     # @movies = Movie.where(rating: @ratings.keys)
    # end
   # elsif @sort
    #  session[:sort] = @sort
     # @movies = Movie.order(@sort.to_sym) # DB order command
   # else
    #  @movies = Movie.all
   # end
   # if !@ratings
    #  @ratings = Hash.new
   # end


    # if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      # session[:sort] = @sort
      # session[:ratings] = @ratings
      # redirect_to(sort: @sort, ratings: @ratings) and return
    # end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
