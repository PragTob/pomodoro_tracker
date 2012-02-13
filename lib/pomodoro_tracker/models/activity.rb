module PomodoroTracker
  class Activity
    attr_accessor :description, :estimate, :priority
    attr_reader   :pomodori, :status

    def initialize(description="" )
      @description = description
      @pomodori = 0
      @status = :inactive
    end

    def start
      @status = :active
    end

    def pause
      @status = :paused
      @pomodori += 1
    end

    def finish
      @status = :finished
      @pomodori += 1
    end

  end
end

