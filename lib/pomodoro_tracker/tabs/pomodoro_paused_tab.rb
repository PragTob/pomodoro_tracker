module PomodoroTracker
  class PomodoroPausedTab < SideTab
    include DynamicSideTab
    SMALL_BREAK_TIME = 2 #60 * 5
    LARGE_BREAK_TIME = 3 * SMALL_BREAK_TIME
    
    def init(activity)
      @activity = activity
      @seconds = break_time
    end
    
    private
    def break_time
      # take a big break every 3 pomodori
      if (@activity.pomodori % 3) == 0
        @seconds = LARGE_BREAK_TIME
      else
        @seconds = SMALL_BREAK_TIME
      end
    end
  end

end
