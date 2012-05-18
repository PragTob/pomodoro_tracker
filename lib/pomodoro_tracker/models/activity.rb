module PomodoroTracker
  class Activity
    attr_accessor :description, :estimate, :priority
    attr_reader   :pomodori, :status

    # by default we don't do tasks today
    def initialize(description = '', estimate = 0, do_today = false)
      @description = description
      @pomodori = 0
      @status = :inactive
      @do_today = do_today
      @estimate = estimate
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
    
    def done_today?
      @do_today
    end
    
    def finished?
      @status == :finished
    end
    
    def do_today
      @do_today = true
    end
    
    def do_another_day
      @do_today = false
    end

  end
end

