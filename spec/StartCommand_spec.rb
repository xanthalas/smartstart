##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas                                                                     #
# Class  :                                                                               #
##########################################################################################
# File   : StartCommand_spec.rb                                                          #
#        : Unit tests for the smartstart class.                                          #
##########################################################################################

require_relative "../StartTypeDay"
require_relative "../StartCommand"

describe "initialize" do
    it "Check that initialiser works correctly" do
        sc = StartCommand.new("testcommand", "day", "mon")
        sc.should be_an_instance_of StartCommand
        sc_command = sc.command
        sc_command.should be_an_instance_of StartTypeDay
        sc.command.start_type.should eq "DAY" 
        sc.isvalid?.should eq true
    end
end

describe "invalidtype" do
    it "Check initialiser with invalid type" do
        sc = StartCommand.new("testcommand", "LunarCycle", "whatever")
        sc.isvalid?.should eq false
    end
end




describe "invalidconditions" do
    it "Check initialiser with invalid conditions" do
        sc = StartCommand.new("testcommand", "day", "")
        sc.isvalid?.should eq false
    end
end

describe "nils" do
    it "Check that passing nil on creation isn't good enough" do
        sc = StartCommand.new("testcommand", "day", nil)
        sc.isvalid?.should eq false

        sc2 = StartCommand.new("testcommand", nil, "whatever")
        sc2.isvalid?.should eq false

        sc3 = StartCommand.new(nil, "IP", "whatever")
        sc3.isvalid?.should eq false


    end
end
