module SwitchBlade
class CLI
  attr_accessor :given_vector
  attr_accessor :available_vector

  def self.parse(argv)
    instance = self.new
    instance.given_vector = argv.map!(&:downcase)
    instance.available_vector = {
      'help' => :print_usage,
      'version' => :print_version,
      'work' => :work,
      'stage' => :stage,
      'release' => :release,
      'compare' => :compare,
      'status' => :print_status
    }
    instance.available_vector.default = :error
    instance.run
  end

  def run
    self.send(available_vector[given_vector.first])
  end

  def work
    puts "Error" and return if given_vector.length > 2
    
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
    puts "Usage: sb sub-command (options)\n\n"
    puts "Available Sub Commands"
    puts "1. sb work cookbook_name"
    exit retval if retval >= 0
  end

  

end
end
