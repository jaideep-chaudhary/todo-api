module V1
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[show update destroy]
    before_action :filter_params, only: %i[update]

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

    # Post /delete/items/:id
    def destroy
      @item.update(deleted: params[:deleted])
      head :no_content
    end

    # GET /get_items
    def get_items
      @items = Item.items_through_tags(params[:title])
    end

    private

    def item_params
      # whitelist params
      params.permit(:id, :name, :status, :deleted, tag_ids: [])
    end

    def set_item
      @item = Item.find_by(_id: params[:id])
    end

    def filter_params
      return unless params[:tag_ids].present?

      params[:tag_ids] = params[:tag_ids].split(',')
    end
  end
end
