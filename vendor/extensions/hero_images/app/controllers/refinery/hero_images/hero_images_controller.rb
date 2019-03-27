module Refinery
  module HeroImages
    class HeroImagesController < ::ApplicationController

      def index
        hero_images = ::Refinery::HeroImages::HeroImage.all
        all_hero_images = hero_images.map { |hero_image| HeroImageSerializer.new(hero_image, { :include => [:image] }).serializable_hash }
        render json: all_hero_images
      end

    end
  end
end
