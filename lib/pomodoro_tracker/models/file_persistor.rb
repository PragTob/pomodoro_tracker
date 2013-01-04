require 'pstore'

module PomodoroTracker
  class FilePersistor

    def initialize(file_path)
      @storage = PStore.new file_path
    end

    def save(activity)
      @storage.transaction do
        @storage[activity.created_at] = activity
      end
    end

    def all
      result = []
      @storage.transaction(true) do
        @storage.roots.each {|activity| result << @storage[activity]}
      end
      result
    end

  end
end