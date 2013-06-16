require 'yaml/store'

module PomodoroTracker
  class FilePersistor

    def initialize(file_path)
      @storage = YAML::Store.new file_path
    end

    def save(activity)
      @storage.transaction do
        @storage[key(activity)] = activity
      end
    end

    def all
      @storage.transaction(true) do
        @storage.roots.map {|activity| @storage[activity]}
      end
    end

    def remove(activity)
      @storage.transaction { @storage.delete key(activity) }
    end

    private
    def key(activity)
      activity.created_at
    end

  end
end