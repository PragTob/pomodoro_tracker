require 'spec_helper'

describe 'Persistor' do

  TEST_FILE_PATH = File.expand_path('../', __FILE__) + '/test_storage.yml'

  before :each do
    @activity = FactoryGirl.build :activity
    @persistor = PomodoroTracker::FilePersistor.new TEST_FILE_PATH
  end

  after :each do
    File.delete TEST_FILE_PATH if File.exist? TEST_FILE_PATH
  end

  it 'saves the activity and returns a truthy value' do
    @persistor.save(@activity).should be_true
  end

  describe 'with an activity' do
    before :each do
      @persistor.save @activity
    end

    let(:retrieved_activity) {retrieved_activity = @persistor.all.first}
    let(:another_activity) {FactoryGirl.build :activity,
                                              description: 'another one'}

    it 'retrieves the saved activities' do
      @persistor.all.should_not be_nil
    end

    it 'retrieves one element' do
      @persistor.all.size.should eq 1
    end

    it 'retrieves a full copy of the activity' do

      @activity.instance_variables.each do |instance_variable|
        actual_value    = @activity.instance_variable_get(instance_variable)
        retrieved_value = retrieved_activity.instance_variable_get(instance_variable)
        actual_value.should == retrieved_value
      end
    end

    it 'can save another activity' do
      @persistor.save another_activity
      @persistor.all.size.should eq 2
    end

    it 'can retrieve and update activities' do
      retrieved_activity.description = 'Muhhh'
      @persistor.save retrieved_activity
      @persistor.all.first.description.should == 'Muhhh'
    end

    it 'can delete an activity' do
      @persistor.remove @activity
      @persistor.all.size.should eq 0
    end

    it 'returns a truthy value when removing an activity' do
      @persistor.remove(@activity).should be_true
    end

    it 'returns a falsy value when trying to remove a non-existant activity' do
      @persistor.remove(another_activity).should be_false
    end

    it 'just deletes one activity' do
      @persistor.save another_activity
      @persistor.remove @activity
      @persistor.all.size.should eq 1
    end
  end

end