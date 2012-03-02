require_relative 'spec_helper'

describe PomodoroTracker::ActivityInventory do
  before :each do
    @inventory = PomodoroTracker::ActivityInventory.new
    @activity = FactoryGirl.build :activity
  end

  it "is empty when created" do
    @inventory.should be_empty
  end

  it "has a size of 0 when created" do
    @inventory.size.should be 0
  end

  it "returns an empty array for activities after creation" do
    @inventory.activities.should == []
  end

  describe "after adding an activity" do

    before :each do
      @inventory.add @activity
    end

    it "is not empty after adding an activity" do
      @inventory.should_not be_empty
    end

    it "has a size of 1" do
      @inventory.size.should be 1
    end

    it "returns the activity as part of all activities" do
      @inventory.activities.should include @activity
    end

  end

end

