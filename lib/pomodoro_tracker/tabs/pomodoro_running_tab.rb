module PomodoroTracker
  class PomodoroRunningTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    include ClockHelper

    POMODORO_TIME = 5 #25 * 60
    PAUSE_TIME    = 2


    # the default argument is necessary so we don't have to pass
    # @activity_inventory over to the paused tab.
    # This tab should always be opened before the paused tab so that's no prob
    def init_data(activity, activity_inventory = nil, options = nil)
      @activity           =   activity
      @activity_inventory ||= activity_inventory
      @options            ||= options
    end

    def content
      init_clock(@options.pomodoro_time) { display_pomodoro_end }
      @info = para working_info 
    end

    def close
      stop_clock
      super
    end

    private
    def display_pomodoro_end
      @content.append do
        @end_buttons = flow do
          finish_button
          pause_button
        end
      end
    end
    
    def finish_button
      button "Finish" do 
        @activity.finish
        @slot_manager.open PomodoroTracker::TodayTab
      end
    end
    
    def pause_button
      button "Pause" do
        @activity.pause
        @slot_manager.open PomodoroPausedTab, @activity, @options
      end
    end

    def working_info
      "You are working on the activity '#{@activity.description}'. " +
      "You are already working on this activity for #{@activity.pomodori} pomodori. " +
      "You estimated that this activity would take you #{@activity.estimate} pomodori to finish."
    end

  end
end

