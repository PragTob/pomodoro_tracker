require 'spec_helper'

describe AfterDo do
  let(:after_do) {Dummy.new.extend AfterDo}
  let(:mockie) {mock}

  class Dummy
    def zero
      0
    end

    def one(param)
      param
    end

    def two(param1, param2)
      param2
    end
  end

  it 'responds to after' do
    after_do.should respond_to :after
  end

  it 'calls a method on the injected mockie' do
    mockie.should_receive :call_method
    after_do.after :zero do mockie.call_method end
    after_do.zero
  end

  it 'does not change the return value' do
    before = after_do.zero
    after_do.after :zero do 42 end
    after = after_do.zero
    after.should eq before
  end

  it 'does not change the behaviour of other objects of this class' do
    after_do.after :zero do mockie.call_method end
    mockie.should_not_receive :call_method
    Dummy.new.zero
  end

  describe 'with parameters' do

    before :each do
      mockie.should_receive :call_method
    end

    it 'can handle methods with a parameter' do
      after_do.after :one do mockie.call_method end
      after_do.one 5
    end

    it 'can handle methods with 2 parameters' do
      after_do.after :two do mockie.call_method end
      after_do.two 5, 8
    end
  end

  describe 'with parameters for the given block' do
    it 'can handle one block parameter' do
      mockie.should_receive(:call_method).with(5)
      after_do.after :one do |i| mockie.call_method i end
      after_do.one 5
    end

    it 'can handle two block parameters' do
      mockie.should_receive(:call_method).with(5, 8)
      after_do.after :two do |i, j| mockie.call_method i, j end
      after_do.two 5, 8
    end
  end

  describe 'multiple methods' do
    def call_all_3_methods
      after_do.zero
      after_do.one 4
      after_do.two 4, 5
    end

    it 'can take multiple method names as arguments' do
      mockie.should_receive(:call_method).exactly(3).times
      after_do.after :zero, :one, :two do mockie.call_method end
      call_all_3_methods
    end

    it 'raises an error when no method is specified' do
      expect do
        after_do.after do mockie.call_method end
      end.to raise_error ArgumentError
    end
  end

  describe 'including into a class' do
    # a new class to avoid messing with the old one
    class Dummy2 < Dummy ; end

    it 'still works to call callbacks' do
      Dummy2.extend AfterDo
      mockie.should_receive :call_method
      Dummy2.after :zero do mockie.call_method end
      instance = Dummy2.new
      instance.zero
    end
  end

  describe 'it can get a hold of self, if needbe' do
    it 'works for a method without arguments' do
      mockie.should_receive(:call_method).with(after_do)
      after_do.after :zero do |object| mockie.call_method(object) end
      after_do.zero
    end

    it 'works for a method with 2 arguments' do
      mockie.should_receive(:call_method).with(1, 2, after_do)
      after_do.after :two do |first, second, object|
        mockie.call_method(first, second, object)
      end
      after_do.two 1, 2
    end
  end
end