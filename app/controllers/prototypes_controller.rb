class PrototypesController < ApplicationController


  before_action :authenticate_user!, only: [:new,:edit, :destroy]



  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new

  end

  def create
    @prototype = Prototype.new(strong_params)

    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
     @prototype = Prototype.find(params[:id])

     unless current_user.id == @prototype.user.id
      redirect_to action: :index
     end

  end

  def update
    @prototype = Prototype.find(params[:id])
    
    if @prototype.update(strong_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end


  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private 

  def strong_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
