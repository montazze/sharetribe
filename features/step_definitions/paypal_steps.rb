def login_as(username, password)
  topbar = FeatureTests::Section::Topbar
  login_page = FeatureTests::Page::Login
  visit("/")
  topbar.click_login_link
  login_page.fill_and_submit(username: username, password: password)
  page.has_content?("Welcome")
end

def logout_foo
  topbar = FeatureTests::Section::Topbar
  topbar.open_user_menu
  topbar.click_logout
  page.has_content?("You have now been logged out of Sharetribe. See you soon!")
end

def connect_marketplace_paypal(admin_username, admin_password)
  topbar = FeatureTests::Section::Topbar
  paypal_preferences = FeatureTests::Section::MarketplacePaypalPreferences
  admin_sidebar = FeatureTests::Section::AdminSidebar

  # Connect Paypal for admin
  login_as(admin_username, admin_password)
  topbar.navigate_to_admin
  admin_sidebar.click_payments_link
  paypal_preferences.connect_paypal_account

  page.has_content?("PayPal account connected")

  # Save payment preferences
  paypal_preferences.set_payment_preferences("2.0", "5", "1.0")
  paypal_preferences.save_settings
  page.has_content?("Payment preferences updated")

  # Dismiss Onboarding Wizard dialog
  page.has_content?("Woohoo, task completed!")
  page.click_on("I'll do it later, thanks")

  logout_foo
end

def connect_seller_paypal(username, password)
  topbar = FeatureTests::Section::Topbar
  settings_sidebar = FeatureTests::Section::UserSettingsSidebar
  paypal_preferences = FeatureTests::Section::UserPaypalPreferences

  # Connect Paypal for seller
  login_as(username, password)
  topbar.open_user_menu
  topbar.click_settings
  settings_sidebar.click_payments_link
  paypal_preferences.connect_paypal_account

  page.has_content?("PayPal account connected")

  # Grant commission fee
  paypal_preferences.grant_permission

  page.has_content?("Hooray, everything is set up!")

  logout_foo
end

Then("I expect transaction with PayPal test to pass") do
  navigation = FeatureTests::Navigation
  data = FeatureTests::Data

  marketplace = data.create_marketplace(payment_gateway: :paypal)
  admin = data.create_member(username: "paypal_admin", marketplace_id: marketplace[:id], admin: true)
  member = data.create_member(username: "paypal_buyer", marketplace_id: marketplace[:id], admin: false)

  navigation.navigate_in_marketplace!(ident: marketplace[:ident])

  # save_screenshot("tmp/screenshots/dev.png")
end
  connect_marketplace_paypal(admin[:username], admin[:password])
  connect_seller_paypal(admin[:username], admin[:password])


