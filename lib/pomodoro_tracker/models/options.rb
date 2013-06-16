require 'yaml/store'

module PomodoroTracker
  class Options

    OPTIONS                     = [:pomodoro_time,
                                   :normal_pause_time,
                                   :extended_pause_time]

    DEFAULT_POMODORO_TIME        = 25
    DEFAULT_NORMAL_PAUSE_TIME   = 5
    DEFAULT_EXTENDED_PAUSE_TIME = 15

    def initialize(file_path)
      @storage = YAML::Store.new file_path
    end

    def self.define_getter(option)
      default_constant = const_get(const_from(option))
      define_method(option) do
        get(option) || default_constant
      end
    end

    def self.const_from(option)
      ('DEFAULT_' + option.to_s.upcase).to_sym
    end

    def self.define_setter(option)
      define_method(setter_name_from(option)) do |value|
        save option, value
      end
    end

    def self.setter_name_from(option)
      (option.to_s + '=').to_sym
    end

    OPTIONS.each do |option|
      define_getter(option)
      define_setter(option)
    end

    private
    def save(key, value)
      @storage.transaction do
        @storage[key] = value
      end
    end

    def get(key)
      @storage.transaction(true) do
        @storage[key]
      end
    end
  end
end