module V1
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[show update destroy]

    # GET /items
    def get_items
      @items = Item.get_item.page(params[:page])
    end

    # GET /items/:id
    def show
      @item
    end

    # POST /items
    def create
      @item = Item.new(item_params)
      if @item.save
        render status: :created
      else
        json_response(@item.errors, 422)
      end
    end

    # PATCH /items/:id
    def update
      @item.update(item_params)
    end

    # DELETE /items/:id
    def destroy
      @item.delete
    end

    # POST /get_items_through_tags
    def get_items_through_tags
      @items = Item.items_through_tags(params[:title])
    end

    # GET /deleted_items
    def deleted_items
      @items = Item.deleted
    end

    # post /undo_delete_item
    def undo_delete_item
      @items = Item.deleted.where(id: params[:id]).restore
    end

    private

    def item_params
      # whitelist params
      params.permit(:id, :name, :status, tag_ids: [])
    end

    def set_item
      @item = Item.find_by(_id: params[:id])
    end

  end
end
