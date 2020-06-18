module V1
  class TagsController < ApplicationController
    before_action :set_tag, only: %i[show update destroy]

    # GET /tags
    def index
      @tags = Tag.all
    end

    # POST /tags
    def create
      @tag = Tag.create!(tag_params)
      render status: :created
    rescue StandardError => e
      json_response(e.message, 422)
    end

    # PATCH /tags/:tag_id
    def update
      @tag.update(tag_params)
      head :no_content
    end

    # DELETE /tags/:id
    def destroy
      @tag.destroy
      head :no_content
    end

    private

    def tag_params
      # whitelist params
      params.permit(:title)
    end

    def set_tag
      @tag = Tag.find_by(_id: params[:id])
    end
  end
end
