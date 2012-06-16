module PomodoroTracker
  class Activity
    attr_accessor :description, :estimate, :priority
    attr_reader   :pomodori, :status
    
    PAUSED = :paused
    INACTIVE = :inactive
    ACTIVE = :active
    FINISHED = :finished

    # by default we don't do tasks today
    def initialize(description = '', estimate = 0, do_today = false)
      @description = description
      @pomodori = 0
      @status = INACTIVE
      @do_today = do_today
      @estimate = estimate
    end

    def start
      @status = ACTIVE
    end

    def pause
      @status = PAUSED
      @pomodori += 1
    end

    def finish
      @status = FINISHED
      @pomodori += 1
    end
    
    def done_today?
      @do_today
    end
    
    def finished?
      @status == FINISHED
    end
    
    def do_today
      @do_today = true
    end
    
    def do_another_day
      @do_today = false
    end
    
    def paused?
      status == PAUSED
    end

  end
end

