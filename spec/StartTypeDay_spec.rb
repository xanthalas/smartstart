##########################################################################################
# Program: smartstart                                                                    #
# Author : Xanthalas                                                                     #
# Class  :                                                                               #
##########################################################################################
# File   : StartTypeDay_spec.rb                                                          #
#        : Unit tests for the StartTypeDay class.                                        #
##########################################################################################

require_relative "../StartTypeDay"

describe "initialize" do
  it "Check that initialiser works correctly" do
      std = StartTypeDay.new("notepad", "MON")
      std.cmd.should eq "notepad"
      std.conditions.should eq "MON"
  end

  it "Pass in a day condition that is not MON, TUE, ... SUN should mark it as invalid" do
      std = StartTypeDay.new "notepad", "JUL"
      std.isvalid?.should eq false
  end

  it "Pass in a day condition that is MON, TUE, ... SUN should mark it as valid" do
      std = StartTypeDay.new "notepad", "MON"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "TUE"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "WED"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "THU"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "FRI"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "SAT"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "SUN"
      std.isvalid?.should eq true
  end

  it "Pass in a set of days condition which is valid should make isvalid? return true" do
      std = StartTypeDay.new "notepad", "MON,TUE,WED"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "THU,FRI,SAT,SUN"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "SAT,MON,FRI"
      std.isvalid?.should eq true
      std = StartTypeDay.new "notepad", "SUN,WED"
      std.isvalid?.should eq true
  end

  it "Pass in a set of days condition which is invalid should make isvalid? return false" do
      std = StartTypeDay.new "notepad", "MON,TUE,AUG"
      std.isvalid?.should eq false
  end

  it "Pass in a condition which is complete rubbish should make isvalid? return false" do
      std = StartTypeDay.new "notepad", "THIS IS A LOAD OF RUBBISH"
      std.isvalid?.should eq false
  end
end
