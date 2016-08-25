module FeatureTests
  module Page
    module Login
      extend Capybara::DSL

      module_function

      def fill_and_submit(username:, password:)
        fill(username: username, password: password)
        submit
      end

      def fill(username:, password:)
        fill_in("main_person_login", with: username)
        fill_in("main_person_password", with: password)
      end

      def submit
        find("#main_log_in_button").click
      end
    end
  end
end
