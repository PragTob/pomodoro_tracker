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

  describe 'with parameterw' do
    class Dummy
      def one(param)
        param
      end

      def two(param1, param2)
        param2
      end
    end

    before :each do
      mockie.should_receive :call_method
    end

    let(:after_param) {Dummy.new.extend AfterDo}

    it 'can handle methods with a parameter' do
      after_param.after :one do mockie.call_method end
      after_param.one 5
    end

    it 'can handle methods with 2 parameters' do
      after_param.after :two do mockie.call_method end
      after_param.two 5, 8
    end
  end
end