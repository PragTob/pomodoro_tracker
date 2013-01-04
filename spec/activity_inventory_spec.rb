require_relative 'spec_helper'

describe PomodoroTracker::ActivityInventory do
  before :each do
    persistor = stub :persistor, all: [], save: true, remove: true
    @inventory = PomodoroTracker::ActivityInventory.new persistor
    @activity = FactoryGirl.build :activity
  end

  it 'is empty when created' do
    @inventory.should be_empty
  end

  it 'has a size of 0 when created' do
    @inventory.size.should be 0
  end

  it 'returns  empty activities after creation' do
    @inventory.activities.should be_empty
  end

  it 'can add activities via <<' do
    @inventory << @activity
    @inventory.size.should eq 1
  end

  it 'can add multiple activities via <<' do
    other_activity    = FactoryGirl.build :activity, description: 'blaah'
    another_activity  = FactoryGirl.build :activity, description: 'woooo'
    @inventory << @activity << other_activity << another_activity
    @inventory.size.should eq 3
  end

  describe 'after adding an activity' do

    before :each do
      @inventory.add @activity
    end

    it 'is not empty after adding an activity' do
      @inventory.should_not be_empty
    end

    it 'has a size of 1' do
      @inventory.size.should be 1
    end

    it 'returns the activity as part of all activities' do
      @inventory.activities.should include @activity
    end

    it 'can be removed' do
      @inventory.remove @activity
      @inventory.size.should eq 0
    end

  end

  describe 'Enumerable' do
    it 'responds to each' do
      @inventory.should respond_to :each
    end

    it 'has a working each' do
      4.times { |i| @inventory.add PomodoroTracker::Activity.new }
      i = 0
      @inventory.each { |each| i+=1 }
      i.should == 4
    end

  end
  
  describe 'accessing different sets of activities' do
  
    DO_TODAY_ACTIVITIES = 3
    BACKLOG_ACTIVITIES = 4
  
    before :each do
      BACKLOG_ACTIVITIES.times do |i| 
        @inventory.add FactoryGirl.build :activity
      end
      
      DO_TODAY_ACTIVITIES.times do |i|
        activity = FactoryGirl.build :activity
        activity.do_today
        @inventory.add activity
      end
    end
    
    it 'can retrieve all the activities that should be done today' do
      @inventory.todo_today.size.should eq DO_TODAY_ACTIVITIES
    end
    
    it 'can retrieve all activities that are still on the inventory list' do
      @inventory.backlog.size.should eq BACKLOG_ACTIVITIES
    end
    
    it 'can retrieve all activities' do
      @inventory.activities.size.should eq DO_TODAY_ACTIVITIES + BACKLOG_ACTIVITIES
    end
    
    it 'does not include finished activities in the todo_today' do
      @inventory.find{|activity| activity.done_today? }.finish
      @inventory.todo_today.size.should eq DO_TODAY_ACTIVITIES - 1
    end
    
    it 'does not include finished activities in the backlog' do
      @inventory.activities.first.finish
      @inventory.backlog.size.should eq BACKLOG_ACTIVITIES - 1 
    end
  end

end

