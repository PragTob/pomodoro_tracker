require 'spec_helper'

describe PomodoroTracker::Day do

  before :each do
    @to_do_today = PomodoroTracker::Day.new
    @activity = FactoryGirl.build :activity
  end

  it "can be created" do
    @to_do_today.should_not be nil
  end

  it 'is empty when created' do
    @to_do_today.should be_empty
  end

  it 'has no activities when created' do
    @to_do_today.activities.should be_empty
  end

  describe "adding activities" do

    before :each do
      @to_do_today.add @activity
    end

    it "can add activities" do
      @to_do_today.should_not be_empty
    end

    it "can retrieve activities" do
      @to_do_today.activities.should include @activity
      @to_do_today.activities.size.should eq 1
    end

    it "can check that an activity is contained" do
      @to_do_today.should include @activity
    end

    it "does not contain activities that were not added to it" do
      unknown_activity = PomodoroTracker::Activity.new "I don't know"
      @to_do_today.should_not include unknown_activity
    end

    it 'doesnt add the same activitiy twice' do
      @to_do_today.add @activity
      @to_do_today.activities.size.should eq 1
    end

  end

  describe "interruptions" do

    it "has no interruptions when created" do
      @to_do_today.interruptions.should eq 0
    end

    it "has no internal interruptions when created" do
      @to_do_today.internal_interruptions.should eq 0
    end

    it "has no external interruptions when created" do
      @to_do_today.external_interruptions.should eq 0
    end

    it "can record internal interruptions" do
      lambda {
        @to_do_today.internal_interrupt
      }.should change(@to_do_today, :internal_interruptions).by(1)
    end

    it "can record external interruptions" do
      lambda {
        @to_do_today.external_interrupt
      }.should change(@to_do_today, :external_interruptions).by(1)
    end

    it "can record the total amount of interruptions" do
      lambda {
        @to_do_today.internal_interrupt
        @to_do_today.external_interrupt
        @to_do_today.internal_interrupt
      }.should change(@to_do_today, :interruptions).by(3)
    end

  end

  describe "date related" do

    before :each do
      Timecop.freeze(@today = Date.today)
      @frozen_day = PomodoroTracker::Day.new
    end

    it "has the correct date set when created" do
      @frozen_day.date.should == @today
    end

    describe "getting today" do
      it "instantiates the day for today" do
        PomodoroTracker::Day.today.date.should == @today
      end

      it "should not create a new object when it is still the same day" do
        day = PomodoroTracker::Day.today
        PomodoroTracker::Day.today.should be_equal day
      end

    end

  end

end

