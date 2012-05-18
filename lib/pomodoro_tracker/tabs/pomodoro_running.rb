module PomodoroTracker
  class PomodoroRunning < SideTab
    include DynamicSideTab

    POMODORO_TIME = 5 #25 * 60
    PAUSE_TIME    = 2

    def init_data(activity)
      @seconds = POMODORO_TIME
      @activity = activity
    end

    def content
      @display = stack margin: 10
      display_time
      clock_ticking

      para "You are working on the activity '#{@activity.description}'"
    end

    def close
      @timer.stop
      super
    end

    private
    def display_time
      @display.clear do
        title "%02d:%02d" % [@seconds / 60 % 60, @seconds % 60], align: "center"
      end
    end

    def clock_ticking
      @timer = animate(1) do
        @seconds -= 1
        display_time
        if @seconds == 0
          @timer.stop
          display_pomodoro_end
        end
      end
    end

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
      button "Pause" do |pause_btn|
        @activity.pause
        @seconds = PAUSE_TIME
        # remove thyself
        pause_btn.parent.remove
        @timer.start
      end
    end

    def add_task
      @task = edit_line
    end

  end
end

