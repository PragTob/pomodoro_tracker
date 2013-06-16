require 'spec_helper'

describe PomodoroTracker::Options do
  TEST_FILE_PATH = File.expand_path('../', __FILE__) + '/test_option_stroage.yml'

  before :each do
    @options = PomodoroTracker::Options.new(TEST_FILE_PATH)
  end

  after :each do
    File.delete TEST_FILE_PATH if File.exist? TEST_FILE_PATH
  end

  describe 'defaults' do
    it 'has a default pomodoro time of 25' do
      @options.pomodoro_time.should eq 25
    end

    it 'has a default normal pause time of 5' do
      @options.normal_pause_time.should eq 5
    end

    it 'has a default extended pause time of 15' do
      @options.extended_pause_time.should eq 15
    end
  end

  it 'saves and retrieves the pomodoro time' do
    @options.pomodoro_time = 5
    @options.pomodoro_time.should eq 5
  end

  it 'saves and retrieve the normal pause time' do
    @options.normal_pause_time = 1
    @options.normal_pause_time.should eq 1
  end

  it 'saves and retrieves the extended pause time' do
    @options.extended_pause_time = 3
    @options.extended_pause_time.should eq 3
  end
end