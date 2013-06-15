require 'spec_helper'

describe AfterDo do
  let(:after_do) {Object.new.extend AfterDo}
  let(:mockie){mock}

  it 'responds to after' do
    after_do.should respond_to :after
  end

  it 'calls a method on the injected mockie' do
    mockie.should_receive :call_method
    after_do.after :object_id do mockie.call_method end
    after_do.object_id
  end

  it 'does not change the return value' do
    before = after_do.object_id
    after_do.after :object_id do 42 end
    after = after_do.object_id
    after.should eq before
  end

  it 'does not change the behaviour of other objects of this class' do
    after_do.after :object_id do mockie.call_method end
    mockie.should_not_receive :call_method
    Object.new.object_id
  end
end