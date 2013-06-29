module PomodoroTracker
  class Activity
    attr_accessor :description, :estimate
    attr_reader   :pomodori, :created_at, :finished_at
    
    PAUSED            = :paused
    INACTIVE          = :inactive
    ACTIVE            = :active
    FINISHED          = :finished
    NO_ESTIMATE_GIVEN = -1

    # by default we don't do tasks today
    def initialize(attributes = {})
      @description = attributes[:description]  || ''
      @do_today    = attributes[:do_today]     || false
      @estimate    = attributes[:estimate]     || NO_ESTIMATE_GIVEN
      @created_at  = Time.now
      @pomodori    = 0
      @status      = INACTIVE
    end

    def start
      @status = ACTIVE
    end

    def pause
      @status = PAUSED
      @pomodori += 1
    end

    def finish
      do_another_day
      @status = FINISHED
      @pomodori += 1
      @finished_at = Time.now
    end

    def resurrect
      @status = PAUSED
    end
    
    def do_today
      @do_today = true
    end
    
    def do_another_day
      @do_today = false
    end

    def done_today?
      @do_today
    end
    
    def paused?
      @status == PAUSED
    end
    
    def inactive?
      @status == INACTIVE
    end
    
    def finished?
      @status == FINISHED
    end
    
    def active?
      @status == ACTIVE
    end

  end
end

