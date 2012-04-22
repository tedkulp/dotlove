Given /^a directory named "([^"]*)" doesn't exist$/ do |directory|
  check_directory_presence([directory], false)
end

Then /^"([^"]*)" is a valid git repository$/ do |directory|
  cd(directory)
  run_simple('git status')
  assert_partial_output('On branch master', all_output)
end

Then /^"([^"]*)" is not a valid git repository$/ do |directory|
  cd(directory)
  run_simple('git status', false)
  assert_partial_output('Not a git repository', all_output)
end
