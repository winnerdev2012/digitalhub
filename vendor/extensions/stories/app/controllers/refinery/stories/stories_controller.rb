module Refinery
  module Stories
    class StoriesController < ::ApplicationController

      before_action :find_all_stories
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @story in the line below:
        present(@page)
      end

      def show
        @story = Story.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @story in the line below:
        present(@page)
      end

      def edit
        @story = Story.find(params[:id])
      end

      def new
        @story = Story.new
      end


      def destroy
        @story = Story.find(params[:id])
        @story.destroy
        redirect_to refinery.stories_stories_url, notice: 'Story was successfully destroyed.'
      end

      def create
        @story = Story.new(story_params)

        if @story.save
          redirect_to refinery.stories_story_path(@story)
        else
          render :new
        end
      end

      def update
        @story = Story.find(params[:id])
        if @story.update(story_params)
          redirect_to refinery.stories_story_path(@story), notice: 'Story was successfully updated.'
        else
          render :edit
        end
      end

    private

      def story_params
        params.require(:story).permit(:title, :question, :video, :response, :audio, :submitter_name)
      end

    protected

      def find_all_stories
        @stories = Story.order('position ASC').where(display: true)
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/stories").first
      end

    end
  end
end
