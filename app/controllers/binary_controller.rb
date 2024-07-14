class BinaryController < ApplicationController
  def index
    @binaries = Binary.all
  end

  def show
    @binary = Binary.find(params[:id])
  end

  def create
  end

  def destroy
    @binary = Binary.find(params[:id])
  end
end
