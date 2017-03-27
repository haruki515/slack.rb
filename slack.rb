require 'pry'
require 'selenium-webdriver'
require 'yaml'

C = YAML.load_file('conf.yml')
SIGN_IN_URL = 'https://slack.com/signin'

client = Selenium::WebDriver::Remote::Http::Default.new
driver = Selenium::WebDriver.for :phantomjs, http_client: client
driver.manage.timeouts.implicit_wait = 10 # seconds

driver.navigate.to SIGN_IN_URL
# teamdomain
driver.find_element(:id, "domain").send_keys(C['domain'])
driver.find_element(:id, "submit_team_domain").submit #click
# google login
if driver.find_elements(:link_text, "Sign in with Google").length > 0
  driver.find_element(:link_text, "Sign in with Google").click
  sleep 10
  driver.find_element(:id, "Email").send_keys(C['mail'])
  driver.find_element(:id, "next").click
  sleep 5
  driver.find_element(:name, "Passwd").send_keys(C['passwd'])
  driver.find_element(:id, "signIn").click
else
  # login情報
  driver.find_element(:id, "email").send_keys("email")
  driver.find_element(:id, "password").send_keys("password")
  driver.find_element(:id, "signin_btn").submit
end
# チャンネル
driver.find_element(:class, C['channel']).click
# 取得
sleep 10
elements = driver.find_elements(:tag_name, "ts-message")
driver.quit
