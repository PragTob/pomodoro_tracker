module PomodoroTracker
  class Activity
    attr_accessor :description, :estimate, :priority
    attr_reader   :pomodori

    def initialize(description="" )
      @description = description
      @pomodori = 0
    end

  end
end

