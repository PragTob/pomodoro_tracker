module PomodoroTracker
  class Pomodoro < SideTab

    def content
      @display = stack margin: 10
      @seconds = 0
      display_time

      animate(1) do
        @seconds += 1
        display_time
      end
    end

    private
    def display_time
      @display.clear do
        title "%02d:%02d:%02d" % [
          @seconds / (60*60),
          @seconds / 60 % 60,
          @seconds % 60
        ]
      end
    end

  end
end

