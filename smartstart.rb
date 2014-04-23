##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas                                                                     #
# Class  : <none>                                                                        #
# File   : smartstart.rb                                                                 #
#        : Top level program for the Smart Start application.                            #
#                                                                                        #
# It uses the command-line parser trollop which must be in your Ruby Path and can be     #
# downloaded from here: http://trollop.rubyforge.org                                     #
##########################################################################################

require 'pry'
require 'yaml'
require_relative './trollop'
require_relative 'StartCommand'

Config_file = 'smartstart_commands.cfg'

opts = Trollop::options do
    version "SmartStart v 0.1 (c) Xanthalas 2014"
  banner <<-EOS
SmartStart is a program launcher. Run it at boot/login to start programs based on criteria such as the day of the week or IP address

Usage:
       smartstart [command] <data>
where [options] are:
EOS
    opt :add, "Add a new startup"
    opt :delete, "Delete an existing startup"
    opt :list, "List all startup"
end

@commands = Array.new

def save_file
  File.open(Config_file, 'w') {|f| f.write @commands.to_yaml }
end

def list_startups
    @commands.each { |c| 
        puts c.start.cmd
    }
end

def add_startup
  if ARGV.empty? or ARGV.count < 3
      puts "smartstart e001: Can't add new startup: too few arguments passed" 
      return
  end

  sc = StartCommand.new(ARGV[0], ARGV[1], ARGV[2])
  if sc.isvalid?
    @commands << sc
    save_file
  else
      puts "smartstart e002: Can't add new startup: invalid arguments"
  end
end

if File.exist?(Config_file)
  @commands = open(Config_file) { |f| YAML.load(f) }
end

list_startups if opts[:list]
add_startup if opts[:add]

