module V1
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[show update destroy]
    skip_before_action :verify_authenticity_token

    # GET /items
    def index
      @items = Item.get_item.page(params[:page])
    end

    # GET /items/:id
    def show
      @item
    end

    # POST /items
    def create
      @item = Item.create!(item_params)
      render status: :created
    rescue StandardError => e
      json_response(e.message, 422)
    end

    # PATCH /items/:id
    def update
      @item.update(item_params)
      head :no_content
    end

    # DELETE /items/:id
    def destroy
      @item.update(deleted: params[:deleted])
      head :no_content
    end

    # GET /get_items
    def get_items
      @items = Item.items_through_tags(params[:title])
                   .page(params[:page])
    end

    private

    def item_params
      # whitelist params
      params.permit(:id, :name, :status, :deleted, :tag_id)
    end

    def set_item
      @item = Item.find_by(_id: params[:id])
    end
  end
end
