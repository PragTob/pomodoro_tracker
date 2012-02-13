module PomodoroTracker
  class PomodoroRunning < SideTab
    POMODORO_TIME = 25 * 60

    def content
      @display = stack margin: 10
      @seconds = POMODORO_TIME
      display_time

      animate(1) do
        @seconds -= 1
        display_time
      end
    end

    private
    def display_time
      @display.clear do
        title "%02d:%02d" % [@seconds / 60 % 60, @seconds % 60], align: "center"
      end
    end

    def add_task
      @task = edit_line
    end

  end
end

