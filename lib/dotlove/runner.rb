module Dotlove
  class Runner
    attr_accessor :repo_dir_name

    def cmd_init(global_options, options, args)
      if File.exists?(@repo_dir_name)
        raise "Repository directory already exists"
      else
        FileUtils.mkdir_p(@repo_dir_name)
        `#{git_command('init')}`
        puts "Repository Initialized"
      end
    end

    def cmd_add(global_options, options, args)
      args.each do |filename|
        if File.symlink?(filename)
          puts "#{filename} - Already Added"
        else
          FileUtils.mv filename, "#{@repo_dir_name}/#{filename}"
          FileUtils.ln_s "#{@repo_dir_name}/#{filename}", filename
          `#{git_command("add #{filename}")}`
          puts "#{filename} - Added"
        end
      end
      puts "File(s) added to repository"
    end

    def cmd_commit(global_options, options, args)
      `#{git_command('add -u')}`
      `#{git_command('commit -m "Updated files"')}`
      puts "File(s) committed"
    end

    def cmd_git(global_options, options, args)
      puts `#{git_command(ARGV[1..-1].join(' '))}`
    end

    def cmd_remove(global_options, options, args)
      args.each do |filename|
        if File.symlink?(filename)
          FileUtils.rm "#{filename}"
          FileUtils.mv "#{@repo_dir_name}/#{filename}", filename
          puts "#{filename} - Removed"
        else
          puts "#{filename} - File is not in the repository"
        end
        puts "File(s) removed from repository"
      end
    end

    private

    def git_command(command = "")
      "git --work-tree=#{repo_dir_name} --git-dir=#{repo_dir_name}/.git #{command}".strip
    end

  end
end
