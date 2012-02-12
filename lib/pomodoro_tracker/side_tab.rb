module PomodoroTracker
  # tabs as inspired by the hacketyhack code
  class SideTab

    def initialize(slot)
      @slot = slot
      @slot.append do
        @content = stack do content end
      end
    end

    def open
      @content.show
    end

    def close
      @content.hide
    end

    def clear &blk
      @content.clear &blk
    end

    def reset
      clear { content }
    end

    # some real evil knievel hack to get initialize and content with normal shoes
    # syntax working presumably by _why himself. Just some method redirection ;-)
    def method_missing(symbol, *args, &blk)
      @slot.app.send(symbol, *args, &blk)
    end

  end
end

