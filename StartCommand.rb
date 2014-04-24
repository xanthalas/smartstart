##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas. Copyright (c) 2014 Xanthalas (xanthalas.live.co.uk)                #
# Class  : StartCommand                                                                  #
# File   : StartCommand.rb                                                               #
#        : Holds details of a particular start command.                                  #
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
require_relative './StartTypeDay'

class StartCommand

  attr_reader :valid

  attr_reader :start

  @valid = false

  @@valid_types = ['DAY', 'IP']

  def initialize(command, type, conditions)
    type = type.upcase if !type.nil?

    if @@valid_types.index(type).nil?
      @valid = false
    else
      @valid = true
    end

    @valid = @valid && (!command.nil? && command.length > 0) && (!conditions.nil? && conditions.length > 0)
    
    if isvalid?
      case type
      when 'DAY'
        @start = StartTypeDay.new(command, conditions)
      end
    end
  end


  def isvalid?
    @valid
  end
  

  def command
    if @valid 
      @start
    else
       nil
    end
  end
end
