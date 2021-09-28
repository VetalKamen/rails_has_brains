class ItemsController < ApplicationController

  before_action :find_item, only: %i[show edit update destroy upvote]
  before_action :check_if_admin, only: %i[edit update new create destroy]

  def index
    @items = Item
    @items = @items.where('price>=?', params[:price_from]) if params[:price_from]
    @items = @items.where('created_at >= ?', 1.day.ago) if params[:today]
    @items = @items.where('votes_count >= ?', params[:votes_from]) if params[:votes_from]
    @items = @items.order('votes_count DESC', 'price')
    # @items = @items.includes(:image)
  end

  def expensive
    @items = Item.where('price>1000')
    render 'index'
  end

  def show
    render text: 'Page not found', status: 404 unless @item
  end

  def edit; end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def update
    @item.update(item_params)
    if @item.errors.empty?
      flash[:success] = 'Item successfully updated'
      redirect_to item_path(@item)
    else
      flash.now[:error] = 'U made mistakes in your form!'
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    render json: { success: true }
    ItemsMailer.item_destroyed(@item).deliver
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: :index
  end

  private

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end

  def item_params
    params.require(:item).permit(:price, :name, :description, :weight, :real)
  end

end
