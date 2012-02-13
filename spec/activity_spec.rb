require 'spec_helper'

describe PomodoroTracker::Activity do
  before :all do
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

  it "can be created given a description" do
    PomodoroTracker::Activity.new("describe me").should_not be nil
  end

end

