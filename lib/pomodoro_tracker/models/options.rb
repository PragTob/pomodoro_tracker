require 'yaml/store'

module PomodoroTracker
  class Options

    DEFAULT_POMDORO_TIME        = 25
    DEFAULT_NORMAL_PAUSE_TIME   = 5
    DEFAULT_EXTENDED_PAUSE_TIME = 15

    def initialize(file_path)
      @storage = YAML::Store.new file_path
    end

    def pomodoro_time
      get(:pomodoro_time) || DEFAULT_POMDORO_TIME
    end

    def normal_pause_time
      get(:normal_pause_time) || DEFAULT_NORMAL_PAUSE_TIME
    end

    def extended_pause_time
      get(:extended_pause_time) || DEFAULT_EXTENDED_PAUSE_TIME
    end

    def pomodoro_time=(value)
      save(:pomodoro_time, value)
    end

    def normal_pause_time=(value)
      save(:normal_pause_time, value)
    end

    def extended_pause_time=(value)
      save(:extended_pause_time, value)
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