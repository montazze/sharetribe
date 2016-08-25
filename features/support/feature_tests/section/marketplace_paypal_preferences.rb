module FeatureTests
  module Section
    module MarketplacePaypalPreferences
      extend Capybara::DSL

      module_function

      def payment_settings
        find(".payment-settings")
      end

      def connect_paypal_account
        payment_settings.click_button("Connect your PayPal account")
      end

      def set_payment_preferences(min_tx_size, tx_fee, min_tx_fee)
        payment_settings.fill_in("paypal_preferences_form[minimum_listing_price]", with: min_tx_size)
        payment_settings.fill_in("paypal_preferences_form[commission_from_seller]", with: tx_fee)
        payment_settings.fill_in("paypal_preferences_form[minimum_transaction_fee]", with: min_tx_fee)
      end

      def save_settings
        payment_settings.click_button("Save settings")
      end
    end
  end
end
