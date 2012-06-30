module PomodoroTracker
  class PomodoroRunningTab < SideTab
    include DynamicSideTab
    include ClockHelper

    POMODORO_TIME = 5 #25 * 60
    PAUSE_TIME    = 2

    def init_data(activity)
      @activity = activity
    end

    def content
      init_clock(POMODORO_TIME) { display_pomodoro_end }
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
        PomodoroTracker::SideTab.open PomodoroTracker::TodayTab 
      end
    end
    
    def pause_button
      button "Pause" do
        @activity.pause
        SideTab.open PomodoroPausedTab, @activity
      end
    end

    def add_task
      @task = edit_line
    end
    
    def working_info
      "You are working on the activity '#{@activity.description}'. " +
      "You are already working on this activity for #{@activity.pomodori} pomodori. " +
      "You estimated that this activity would take you #{@activity.estimate} pomodori to finish."
    end

  end
end

