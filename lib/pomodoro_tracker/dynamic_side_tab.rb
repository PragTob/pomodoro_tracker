module PomodoroTracker
  # A side tab that loads new contents every time it is openend
  module DynamicSideTab

    def initialize(slot, *args)
      @slot = slot
      @slot.append do
        @content = stack do;end
      end
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

