module Sorcery
  module TestHelpers
    module Rails
      def login_user(user)
        @request.session[:user_id] = user.id
      end

      def logout_user
        @request.session[:user_id] = nil
      end
    end
  end
end

RSpec.configure do |config|
  config.include Sorcery::TestHelpers::Rails, type: :controller
end