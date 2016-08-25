module FeatureTests
  module Page
    module Topbar
      extend Capybara::DSL

      module_function

      def click_login_link
        header.click_link("Log in")
      end

      def navigate_to_admin
        open_menu
        click_admin_link
      end

      def open_menu
        header.find('span', text: "Menu").click
      end

      def click_admin_link
        header.click_on("Admin")
      end

      def header
        find(".header")
      end
    end
  end
end
