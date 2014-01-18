Given(/^a missing config file$/) do
  !File.exists?("/tmp/storm_fury/.fog")
end

When(/^I run a "(.*?)" command$/) do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} servers create`)
end
