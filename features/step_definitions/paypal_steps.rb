Then("I expect transaction with PayPal test to pass") do
  login_page = FeatureTests::Page::Login
  topbar = FeatureTests::Page::Topbar
  navigation = FeatureTests::Navigation
  data = FeatureTests::Data
  admin_sidebar = FeatureTests::Page::AdminSidebar

  marketplace = data.create_marketplace(payment_gateway: :paypal)
  admin = data.create_member(username: "paypal_admin", marketplace_id: marketplace[:id], admin: true)
  member = data.create_member(username: "paypal_buyer", marketplace_id: marketplace[:id], admin: false)

  navigation.navigate_in_marketplace!(ident: marketplace[:ident])
  visit("/")

  topbar.click_login_link
  login_page.fill_and_submit(username: admin[:username], password: admin[:password])
  topbar.navigate_to_admin
  admin_sidebar.click_payments_link

  # save_screenshot("tmp/screenshots/dev.png")
end


