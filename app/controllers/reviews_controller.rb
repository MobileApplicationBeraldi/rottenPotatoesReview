class ReviewsController < ApplicationController
 
 before_action :has_movie

 def has_movie
   unless (@movie = Movie.find(params[:movie_id]))
   flash[:warning] = "Review must be for an existing movie"
   redirect_to movies_path
   end
 end
 
 def new
  
 end
 
 def create #This action can be executed only by a logged user
	    #This check is done in app controller for all actions
 #@movie is set in the before_action
 @review = @movie.reviews.build(params[:review].permit(:potatoes,:comment))
 @review.user=@current_user
 r=@review.save!
 
 flash[:notice] = "Review has been successfully  added to #{@movie.title}."
 redirect_to movie_path(@movie)
 end 

 def destroy
  @review = Review.find(params[:id])
  @review.destroy
  flash[:notice] = "Your review has been deleted."
  redirect_to movie_path(@movie)
 end

 def index
  @reviews=@current_user.reviews
  @reviews=Review.where(:movie_id => params[:movie_id])
  unless (@reviews!=[])
   flash[:warning] = "You have no reviews to delete"
   redirect_to movie_path(@movie)
  end
 end
end
