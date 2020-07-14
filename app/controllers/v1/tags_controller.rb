module V1
  class TagsController < ApplicationController
    before_action :set_tag, only: %i[show update destroy]

    # GET /get_tags
    def get_tags
      @tags = Tag.all
    end

    # POST /tags
    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        render status: :created
      else
        json_response(@tag.errors, 422)
      end
    end

    # PATCH /tags/:tag_id
    def update
      @tag.update(tag_params)
    end

    # DELETE /tags/:id
    def destroy
      @tag.destroy
    end

    private

    def tag_params
      # whitelist params
      params.permit(:title, :id)
    end

    def set_tag
      @tag = Tag.find_by(_id: params[:id])
    end
  end
end
