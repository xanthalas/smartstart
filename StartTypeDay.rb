##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas                                                                     #
# Class  : StartTypeDay                                                                  #
# File   : StartTypeDay.rb                                                               #
#        : Functionality and processing for DAY filter commands.                         #
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
      return @conditions.upcase == today
  end
end
