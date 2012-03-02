require 'spec_helper'

describe PomodoroTracker::ToDoToday do

  before :each do
    @to_do_today = PomodoroTracker::ToDoToday.new
    @activity = FactoryGirl.build :activity
  end

  it "can be created" do
    @to_do_today.should_not be nil
  end

  it 'is empty when created' do
    @to_do_today.should be_empty
  end

  it 'has no activities when created' do
    @to_do_today.activities.should == []
  end

  describe "adding activities" do

    before :each do
      @to_do_today.add @activity
    end

    it "can add activities" do
      @to_do_today.should_not be_empty
    end

    it "can retrieve activities" do
      @to_do_today.activities.should == [@activity]
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
      @frozen_day = PomodoroTracker::ToDoToday.new
    end

    it "has the correct date set when created" do
      @frozen_day.date.should == @today
    end

  end

end

