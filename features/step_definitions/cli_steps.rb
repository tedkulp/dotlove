Given /^a directory named "([^"]*)" doesn't exist$/ do |directory|
  check_directory_presence([directory], false)
end

Then /^"([^"]*)" is a valid git repository$/ do |directory|
  pwd = Dir.pwd
  dirs = @dirs
  cd(directory)
  Dir.chdir(current_dir)
  %x(git rev-parse --git-dir).chomp.should == '.git'
  Dir.chdir(pwd)
  @dirs = dirs
end

Then /^"([^"]*)" is not a valid git repository$/ do |directory|
  pwd = Dir.pwd
  dirs = @dirs
  cd(directory)
  Dir.chdir(current_dir)
  %x(git rev-parse --git-dir).chomp.should_not == '.git'
  Dir.chdir(pwd)
  @dirs = dirs
end

Then /^a file named "([^"]*)" is symlinked to "([^"]*)"$/ do |arg1, arg2|
  pwd = Dir.pwd
  dirs = @dirs
  Dir.chdir(current_dir)
  File.readlink(arg1).should == arg2
  Dir.chdir(pwd)
  @dirs = dirs
end

Given /^a working repository$/ do
  run_simple("bundle exec dotlove init")
end
