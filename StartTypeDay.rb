##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas. Copyright (c) 2014 Xanthalas (xanthalas.live.co.uk)                #
# Class  : StartTypeDay                                                                  #
# File   : StartTypeDay.rb                                                               #
#        : Functionality and processing for DAY filter commands.                         #
#        : Filter conditions for DAYs are either a single three-character day name       #
#        : (e.g. MON) or a comma-delimited list of three-character names (e.g. MON,TUE)  #
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

class StartTypeDay
  
  attr_accessor :cmd

  attr_accessor :conditions
  
  attr_accessor :reverse_test

  def initialize(command, conditions)
    @cmd = command
    @conditions = conditions
    @reverse_test = false
  end
  
  def start_type
    return 'DAY'
  end

  def start?
    today = Time.now.strftime("%^a")
    if @conditions.include? ","
      days = @conditions.split(",")
      if days.count == 0
        puts "smartstart e006: Command #{cmd}: The DAY condition is not valid. Should be a comma-delimited list of three-character day names. For example MON,WED,FRI"
      else
        days.each { |s| 
          if s.strip.length != 3
            puts "smartstart e007: Command #{cmd}: The DAY condition is not valid. Should be a comma-delimited list of three-character day names. For example MON,WED,FRI"
            return false
          end
           
          if s.strip.upcase == today
            return true
          end
        }
        return false
      end
    else
      if @conditions.strip.length != 3
        puts "smartstart e008: Command #{cmd}: The DAY condition is not valid. Should be a three-character day name. For example WED"
      else
        return @conditions.upcase == today
      end
    end
  end
end
