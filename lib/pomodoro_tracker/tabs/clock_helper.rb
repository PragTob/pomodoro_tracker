module PomodoroTracker
  module ClockHelper
    
    # the seconds until &block gets executed
    def init_clock(seconds, &block)
      @seconds = seconds
      @display = stack margin: 10
      display_time
      clock_ticking(&block)
    end
    
    def display_time
      @display.clear do
        title "%02d:%02d" % [@seconds / 60 % 60, @seconds % 60], align: "center"
      end
    end

    # executes block when the time reaches zero
    def clock_ticking(&block)
      @timer = animate(1) do
        @seconds -= 1
        display_time
        if @seconds == 0
          @timer.stop
          block.call
        end
      end
    end
    
    def stop_clock
      @timer.stop
    end

    def close
      stop_clock
      super
    end
  end
end
