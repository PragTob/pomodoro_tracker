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

  it "returns  empty activities after creation" do
    @inventory.activities.should be_empty
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

  describe "Enumerable" do
    it "responds to each" do
      @inventory.should be_respond_to :each
    end

    it "has a working each" do
      4.times { |i| @inventory.add PomodoroTracker::Activity.new i.to_s }
      i = 0
      @inventory.each { |each| i+=1 }
      i.should == 4
    end

  end
  
  it 'can retrieve all the activities that should be done today' do
    4.times { |i| @inventory.add PomodoroTracker::Activity.new i.to_s }
    3.times { |i| @inventory.add PomodoroTracker::Activity.new i.to_s, true }
    
    @inventory.todo_today.size.should eq 3
  end
    

end

