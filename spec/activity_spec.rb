require 'spec_helper'

describe PomodoroTracker::Activity do
  before :each do
    @activity = FactoryGirl.build :activity
  end

  it "has a description" do
    @activity.description.should_not be nil
  end

  it "has an estimate" do
    @activity.estimate.should_not be nil
  end

  it "has a priority" do
    @activity.priority.should_not be nil
  end

  it "has 0 pomodori when created" do
    @activity.pomodori.should eq 0
  end

  it "can be created given a description and then the description is correct" do
    PomodoroTracker::Activity.new("describe me").description
                                                .should == "describe me"
  end
  
  it "can be created given a description and an estimate" do
    PomodoroTracker::Activity.new("describe me", 5).estimate.should == 5
  end
  
  it 'is not done today by default' do
    @activity.should_not be_done_today
  end
  
  it 'can be created so that it should get done today' do
    PomodoroTracker::Activity.new('urgent', 0, true).should be_done_today
  end

  it "has a status of inactive by default" do
    @activity.status.should be :inactive
  end
  
  describe "actions" do

    describe "after start" do

      before :each do
        @activity.start
      end

      it "can be started and changes the status to working" do
        @activity.status.should be :active
      end

      it "can be paused (not finished after pomodoro)" do
        @activity.pause
        @activity.status.should be :paused
      end

      it "has a pomodori count of 1 after one pause" do
        @activity.pause
        @activity.pomodori.should be 1
      end

      it "can be paused and then started again" do
        @activity.pause
        @activity.start
        @activity.status.should be :active
      end

      it "can be finished" do
        @activity.finish
        @activity.status.should be :finished
      end

      it "has a pomodri count of 1 after one finish" do
        @activity.finish
        @activity.pomodori.should be 1
      end

    end
    
    describe 'do it today or another day' do
      it 'can be done today' do
        @activity.do_today
        @activity.should be_done_today
      end
      
      it 'can be done another day if you decide that today isnt suitable' do
        @activity.do_today
        @activity.do_another_day
        
        @activity.should_not be_done_today
      end
    end

  end

end

