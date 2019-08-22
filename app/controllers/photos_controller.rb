class PhotosController < ApplicationController
  before_action :admin_user,     except: [:index, :show]

  def index
    @photos = Photo.paginate(page: params[:page])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:notice] = "Photo created"
      redirect_to(@photo)
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    if @photo.save
      flash.notice = "Photo updated!"
      redirect_to(@photo)
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash.now[:notice] = "Photo deleted"
      redirect_to photos_path
    else
      render @photo
    end
  end


  private

  def photo_params
    params.require(:photo)
          .permit(:title, :image)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
