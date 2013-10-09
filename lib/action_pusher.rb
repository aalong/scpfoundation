class ActionPusher < AbstractController::Base
  include AbstractController::Rendering
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Rails.application.routes.url_helpers
  helper ApplicationHelper
  self.view_paths = "app/views"

  class Pushable
    def initialize(channel, pushtext)
      @channel = channel
      @pushtext = pushtext
    end

    def push
      PrivatePub.publish_to @channel, @pushtext
    end
  end
end
