Given /^a directory named "([^"]*)" doesn't exist$/ do |directory|
  check_directory_presence([directory], false)
end

Then /^"([^"]*)" is a valid git repository$/ do |directory|
  in_subdirectory(directory) do
    %x(git rev-parse --git-dir).chomp.should == '.git'
  end
end

Then /^"([^"]*)" is not a valid git repository$/ do |directory|
  in_subdirectory(directory) do
    %x(git rev-parse --git-dir).chomp.should_not == '.git'
  end
end

Then /^a file named "([^"]*)" is symlinked to "([^"]*)"$/ do |arg1, arg2|
  in_directory do
    File.readlink(arg1).should == arg2
  end
end

Given /^a working repository$/ do
  run_simple("dotlove init")
end

Then /^a file named "([^"]*)" is staged to be committed in "([^"]*)"$/ do |file, directory|
  in_subdirectory(directory) do
    %x(git status --porcelain).chomp.should match /A\ +#{file}/mi
  end
end

# Run a block of code in current Aruba test
# directory. Makes sure that # it's reset back
# to the proper Aruba test # directory before
# exiting the block
#
# block - The block of code to run in the context
#         of the Aruba test directory
#
# Returns nothing
def in_directory(&block)
  pwd = Dir.pwd
  dirs = @dirs
  Dir.chdir(current_dir)
  begin
    yield
  rescue Exception => e
    raise e
  ensure
    Dir.chdir(pwd)
    @dirs = [dirs[0]]
  end
end

# Run a block of code in a subdirectory of the
# current Aruba test directory. Makes sure that
# it's reset back to the proper Aruba test
# directory before exiting the block
#
# directory - The subdirectory to switch to
# block     - The block of code to run in the context
#             of the given subdirectory
#
# Returns nothing
def in_subdirectory(directory, &block)
  pwd = Dir.pwd
  dirs = @dirs
  cd(directory)
  Dir.chdir(current_dir)
  begin
    yield
  rescue Exception => e
    raise e
  ensure
    Dir.chdir(pwd)
    @dirs = [dirs[0]]
  end
end
