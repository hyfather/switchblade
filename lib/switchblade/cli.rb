module SwitchBlade
class CLI
  def self.parse(vector)
    vector.map!(&:downcase)
    commands_map = {
      'help' => :print_usage,
      'version' => :print_version,
      'work' => :work,
      'stage' => :stage,
      'release' => :release,
      'compare' => :compare,
      'status' => :print_status
    }
    commands_map.default = :error
    self.new.send(commands_map[vector[0]])
  end

  def print_version
    puts "alpha 0.1"
  end

  def error
    puts "ERROR PARSING COMMAND \n\n"
    print_usage(1)
  end

  def print_status
    puts "============ SwitchBlade Status =============="
    puts "Current Git remotes --"
    puts `git remote -v`
    puts "\n\nConfigured Chef Servers -- "
    puts "Production: #{SBConfig.chef_production}"
    puts "   Staging: #{SBConfig.chef_staging}"
    puts "\n=============================================\n\n"
  end


  def print_usage(retval=0)
    puts "Usage --"
    puts "Before starting work on a cookbook, ensure that you have no local changes in your git repository."
    puts "You can do by running `git status`. If you wipe off all your local changes and reset your repository,"
    puts "running `rake reset` will cause sb to wipe off all local changes and pull from the origin remote.\n"
    puts "`rake work cookbook_name` -- When you are ready to work on a cookbook, sb will move you to a git branch for the cookbook."
    puts "`rake stage cookbook_name`"
    exit retval if retval >= 0
  end
end
end
