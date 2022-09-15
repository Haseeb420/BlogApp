# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_post_by_post_id
  before_action :build_suggestion, only: [:create]

  def index
  end
  def create
    @notice = if @suggestion.save
      "Suggestion added successfully"
    else
      "Suggestion not added"
    end
    respond_to do |format|
      format.js { render "moderators/post_details.js.erb" }
    end
  end

  def destroy; end

  private
    def suggestion_params
      params.require(:suggestion).permit(:body)
    end

    def build_suggestion
      @suggestion = @post.suggestions.build(suggestion_params)
    end
end
