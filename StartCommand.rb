##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas                                                                     #
# Class  : StartCommand                                                                  #
# File   : StartCommand.rb                                                               #
#        : Holds details of a particular start command.                                  #
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
