module PomodoroTracker
  class PomodoroPausedTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    include ClockHelper
    
    SMALL_PAUSE_TIME = 2 #60 * 5
    LARGE_PAUSE_TIME = 3 * SMALL_PAUSE_TIME
    
    def init_data(activity)
      @activity = activity
    end
    
    def content
      init_clock(pause_time) { display_pause_end }
      @info = para pause_info
    end
    
    private
    def pause_time
      # take a big break every 3 pomodori
      if (@activity.pomodori % 3) == 0
        @seconds = LARGE_PAUSE_TIME
      else
        @seconds = SMALL_PAUSE_TIME
      end
    end
    
    def pause_info
      "You shouldn't be reading this right now! " + 
      "It's time for a break and therefore you should step aways from the " +
      "keyboard and enjoy your break!"
    end
    
    def display_pause_end
      @info.replace pause_end_info
      @content.append { resume_work_button }
    end
    
    def pause_end_info
      'That was your break - hope you enjoyed! Time to get back to work again!'
    end
    
    def resume_work_button
      button 'Resume Work' do @slot_manager.open PomodoroRunningTab, @activity end
    end
    
  end

end
