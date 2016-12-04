class GenresController < ApplicationController
  def index
    @genres = Genre.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "Genre was created successfully"
      redirect_to genres_path
    else
      render 'new'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = "Genre name was successfully updated"
      redirect_to genre_path(@genre)
    else
      render 'edit'
    end
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_books = @genre.books.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
