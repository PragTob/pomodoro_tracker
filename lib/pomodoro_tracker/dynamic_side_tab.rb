module PomodoroTracker
  # A side tab that loads new contents every time it is openend
  module DynamicSideTab

    def init_slot
      @slot.append{ @content = stack do;end }
    end

    # ocerwrite the old content
    def open(*args)
      @slot.append do
        @content = stack do content(*args) end
      end
    end

    def close
      clear
    end

  end
end

