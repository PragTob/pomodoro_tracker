module PomodoroTracker
  class ActivityInventory
    include Enumerable

    attr_reader :activities

    def initialize(persistor)
      @persistor  = persistor
      @activities = @persistor.all
    end

    def add(activity)
      @persistor.save activity
      @activities << activity
    end

    def <<(activity)
      add activity
      self
    end

    def remove(activity)
      @persistor.remove activity
      @activities.delete activity
    end

    def size
      @activities.size
    end

    def empty?
      @activities.empty?
    end

    def each(&blk)
      @activities.each(&blk)
    end
    
    def todo_today
      @activities.select{|activity| activity.done_today? && !activity.finished?}
    end
    
    def backlog
      @activities.reject{|activity| activity.done_today? || activity.finished?}
    end

  end
end

