require 'rack'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/angular'

Capybara.default_driver = :poltergeist
Capybara.app = Rack::Directory.new('spec/public')
Capybara.default_max_wait_time = 2
Capybara::Angular.default_max_wait_time = 10

feature 'Waiting for angular' do
  include Capybara::Angular::DSL

  scenario 'when manually bootstrapping an angular application' do
    open_manual_bootstrap_page
    timeout_page_should_have_waited
  end

  scenario 'when manually bootstrapping an angular application after a delay' do
    open_delayed_manual_bootstrap_page
    timeout_page_should_have_waited
  end

  scenario 'when using ng-app to bootstrap an application' do
    open_ng_app_bootstrap_page
    timeout_page_should_have_waited
  end

  scenario 'when using ng-app not on the body tag to bootstrap an application' do
    open_ng_app_not_on_body_bootstrap_page
    timeout_page_should_have_waited
  end

  def open_manual_bootstrap_page
    visit '/manual.html'
  end

  def open_delayed_manual_bootstrap_page
    visit '/delayed-manual.html'
  end

  def open_ng_app_bootstrap_page
    visit '/ng-app.html'
  end

  def open_ng_app_not_on_body_bootstrap_page
    visit '/ng-app-not-on-body.html'
  end

  def timeout_page_should_have_waited
    expect(page).to have_content('waited')
  end
end
