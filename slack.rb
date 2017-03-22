require 'pry'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for(:phantomjs)
driver.navigate.to "https://slack.com/signin"
# teamdomain
driver.find_element(:id, "domain").send_keys("domain")
driver.find_element(:id, "submit_team_domain").submit #click
# google login
if driver.find_elements(:link_text, "Sign in with Google").length > 0
 driver.find_element(:link_text, "Sign in with Google").click
 driver.find_element(:id, "Email").send_keys("email")
 driver.find_element(:id, "next").click
 driver.find_element(:name, "Passwd").send_keys("password")
 puts "password done"
 driver.find_element(:id, "signIn").click
else
# login情報
 driver.find_element(:id, "email").send_keys("email")
 driver.find_element(:id, "password").send_keys("password")
 driver.find_element(:id, "signin_btn").submit
end
# チャンネル
driver.find_element(:class, "channel_C45AADH7B").click
# 取得
sleep 5
elements = driver.find_elements(:tag_name, "ts-message")
puts elements.last.text
driver.quit
