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

    class << self

      # setup given the slot where the tab content should be displayed
      def setup(slot)
        @loaded_tabs = {}
        @slot = slot
      end

      def open(tab)
        @current_tab.close unless @current_tab.nil?
        @current_tab = get_tab(tab)
        @current_tab.open
      end

      private

      def get_tab(tab_class)
        if @loaded_tabs.include?(tab_class)
          return @loaded_tabs[tab_class]
        else
          # load the class responding to the symbol(the desired tab)
          # the class could also be required just here, what do you think?
          @loaded_tabs[tab_class] = tab_class.new(@slot)
        end
      end

    end

  end
end

