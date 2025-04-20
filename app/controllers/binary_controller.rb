class BinaryController < ApplicationController
  before_action :set_binary, only: [:show, :edit, :update]

  def index
    @binaries = Binary.all
    @search_result = @binaries.search_title(params[:title]).order(:created_at)
  end

  def show
  end

  def edit
    @tags = Tag.all
  end

  def update
    if params[:remove_image] == '1' && @binary.image.attached?
      @binary.image.purge
    end
    # 新規タグの処理
    if params[:new_tag].present? && params[:new_tag][:name].present?
      tag = Tag.find_or_create_by(name: params[:new_tag][:name]) do |t|
        t.context = params[:new_tag][:context]
        t.color = params[:new_tag][:color] || '#FFFFFF'
      end
      @binary.tags << tag if tag.present? && !@binary.tags.include?(tag)
    end

    if @binary.update(binary_params)
      flash.now[:success] = '日記の編集完了'
      redirect_to binary_path(@binary.id)
    else
      @tags = Tag.all
      render :edit
    end
  end

  def new
    @binary = Binary.new
    @tags = Tag.all
  end

  def create
    @binary = Binary.new(binary_params)
    @tags = Tag.all

    if params[:new_tag].present? && params[:new_tag][:name].present?
      tag = Tag.find_or_create_by(name: params[:new_tag][:name]) do |t|
        t.context = params[:new_tag][:context]
        t.color = params[:new_tag][:color] || '#FFFFFF'
      end
    end
    @binary.tags << tag if tag.present? && !@binary.tags.include?(tag)

    if @binary.save
      flash.now[:success] = '日記の投稿完了'
      redirect_to binary_path(@binary.id)
    else
      render :new
    end
  end

  def destroy
    binary = Binary.find(params[:id])
    if binary.delete
      flash.now[:success] = '日記の削除完了'
      redirect_to binary_index_path
    else
      flash.now[:error] = '日記の削除失敗'
      render :show
    end
  end

  private

  def set_binary
    @binary = Binary.find(params[:id])
  end

  def binary_params
    params.require(:binary).permit(:title, :context, :image, tag_ids: [])
  end
end
