class BinaryController < ApplicationController
  def index
    @binaries = Binary.all
  end

  def show
    @binary = Binary.find(params[:id])
  end

  def new
    @binary = Binary.new
  end

  def create
    @binary = Binary.new(binary_params)
    if @binary.save
      flash.now[:success] = '日記の投稿完了'
      redirect_to binary_index_path
    else
      render :new
    end
  end

  def destroy
    @binary = Binary.find(params[:id])
  end

  private

  def binary_params
    params.require(:binary).permit(:title, :context)
  end
end
