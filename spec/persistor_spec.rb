require_relative 'spec_helper'

describe 'Persistor' do

  TEST_FILE_PATH = File.expand_path('../', __FILE__) + '/test_storage.pstore'

  before :each do
    @activity = FactoryGirl.build :activity
    @persistor = PomodoroTracker::FilePersistor.new TEST_FILE_PATH
  end

  after :each do
    File.delete TEST_FILE_PATH
  end

  it 'saves the activity and returns a truthy value' do
    @persistor.save(@activity).should be_true
  end

  describe 'retrieving activities' do
    before :each do
      @persistor.save @activity
    end

    it 'retrieves the saved activities' do
      @persistor.all.should_not be_nil
    end

    it 'retrieves one element' do
      @persistor.all.size.should eq 1
    end

    it 'retrieves a full copy of the activity' do
      retrieved_activity = @persistor.all.first
      @activity.instance_variables.each do |instance_variable|
        actual_value    = @activity.instance_variable_get(instance_variable)
        retrieved_value = retrieved_activity.instance_variable_get(instance_variable)
        actual_value.should == retrieved_value
      end
    end

    it 'can save another activity' do
      another_activity = FactoryGirl.build :activity, description: 'another one'
      @persistor.save another_activity
      @persistor.all.size.should eq 2
    end
  end

end