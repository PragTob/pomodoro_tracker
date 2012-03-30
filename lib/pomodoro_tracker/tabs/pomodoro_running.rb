module PomodoroTracker
  class PomodoroRunning < SideTab
    include DynamicSideTab

    POMODORO_TIME = 5 #25 * 60

    def init_data(activity)
      @seconds = POMODORO_TIME
      @activity = activity
    end

    def content(activity)
      @display = stack margin: 10
      display_time
      clock_ticking

      para "You are working on the activity '#{activity.description}'"
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
          button "Finish" do @activity.finish end
          button "Pause" do @activity.pause end
        end
      end
    end

    def add_task
      @task = edit_line
    end

  end
end

