module PomodoroTracker
  module ClockHelper

    FINISH_SOUND = File.expand_path('../../../../sounds/alarm-clock.wav',
                                    __FILE__)

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
        if time_ran_out?
          stop_clock
          play_finish_sound
          block.call
        end
      end
    end

    def time_ran_out?
      @seconds == 0
    end

    def stop_clock
      @timer.stop
    end

    def close
      stop_clock
      super
    end

    # needs the sox package http://sox.sourceforge.net/
    def play_finish_sound
      # new thread (the &) is needed so it does not block
      command = 'play ' + FINISH_SOUND + ' &'
      system command
    end
  end
end
