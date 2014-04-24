##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas. Copyright (c) 2014 Xanthalas (xanthalas.live.co.uk)                #
# Class  : <none>                                                                        #
# File   : smartstart.rb                                                                 #
#        : Top level program for the Smart Start application.                            #
#                                                                                        #
#          It uses the command-line parser trollop which must be in your Ruby Path and   #
#          can be downloaded from here: http://trollop.rubyforge.org                     #
##########################################################################################
#          This file is part of smartstart.                                              #
#                                                                                        #
#          smartstart is free software: you can redistribute it and/or modify            #
#          it under the terms of the GNU General Public License as published by          #
#          the Free Software Foundation, either version 3 of the License, or             #
#          (at your option) any later version.                                           #
#                                                                                        #
#          Foobar is distributed in the hope that it will be useful,                     #
#          but WITHOUT ANY WARRANTY; without even the implied warranty of                #
#          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 #
#          GNU General Public License for more details.                                  #
#                                                                                        #
#          You should have received a copy of the GNU General Public License             #
#          along with Foobar.  If not, see <http://www.gnu.org/licenses/>.               #
##########################################################################################

require 'pry'
require 'yaml'
require_relative './trollop'
require_relative 'StartCommand'

Config_file = 'smartstart_commands.cfg'

#{{{ Trollop setup
opts = Trollop::options do
  version "SmartStart v 0.1 (c) Xanthalas 2014"
  banner <<-EOS
SmartStart is a program launcher. Run it at boot/login to start programs based on criteria such as the day of the week or IP address

Usage:
       smartstart option command type conditions
where option is:
EOS
  opt :add, "Add a new startup"
  opt :delete, "Delete an existing startup"
  opt :list, "List all startups"
  opt :run, "Run all startups"
end
#}}}

@commands = Array.new

#{{{ methods
def save_file
  File.open(Config_file, 'w') {|f| f.write @commands.to_yaml }
end

def list_startups
  if @commands.count == 0
    puts "There are no startup commands currently set up. Use smartstart --add to add one"
    return
  end
  index = 1
  @commands.each { |c| 
    puts index.to_s + ". " + c.start.cmd + " [Type=" + c.start.start_type + "] [Condition=" + c.start.conditions + "]"
    index+=1
  }
end

def add_startup
  if ARGV.empty? or ARGV.count < 3
    puts "smartstart e001: Can't add new startup: too few arguments passed" 
    return
  end

  sc = StartCommand.new(ARGV[0], ARGV[1], ARGV[2])
  if sc.isvalid? and sc.start.isvalid?
    @commands << sc
    save_file
  else
    puts "smartstart e002: Can't add new startup: invalid arguments"
  end
end

def delete_startup(index)
  if index.nil?
    puts "smartstart e003: Please specify the number of the command you want to delete. e.g. smartstart --delete 2"
  else
    index = index.to_i
    if @commands.count <= (index-1) or index < 1
      puts "smartstart e004: Command number #{index} can't be found"
    else
      @commands.delete_at(index-1)
      save_file
    end
  end
end

def run
  if @commands.count == 0
    puts "smartstart e005: There are no commands to run. Use smartstart --add to add a command"
  else
    commands_run_count = 0
    @commands.each { |c| 
      if c.isvalid?
        if c.start.start?
          puts "Starting command #{c.start.cmd}"
          begin
            Process.spawn('"' + c.start.cmd + '"')
            commands_run_count += 1
          rescue
            puts "smartstart e009: An error occurred while trying to run command #{c.start.cmd}"
          end
        else
          puts "Command #{c.start.cmd} won't be run"
        end
      end
    }
  end
end
#}}}

if File.exist?(Config_file)
  @commands = open(Config_file) { |f| YAML.load(f) }
end

list_startups if opts[:list]
add_startup if opts[:add]
delete_startup(ARGV[0]) if opts[:delete]
run if opts[:run]
