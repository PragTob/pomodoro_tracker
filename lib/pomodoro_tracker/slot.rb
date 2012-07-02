module ShoesSlotManager
  # slots/tabs as inspired by the original hacketyhack code
  # you can define a slot and then show different contents there while hiding
  # older contents
  class Slot

    # may be overriden to provide some none UI initialization
    def init_data(*args)
    end

    def init_slot
      @slot.append{ @content = stack{content} }
    end

    def initialize(slot, *args)
      init_data(*args)
      @slot = slot
      init_slot
    end

    def open(*args)
      @content.show
    end

    def close
      @content.hide
    end

    def clear &blk
      @content.clear &blk
    end

    def reset(*args)
      clear do
        init_data(*args)
        content
      end
    end
    
    # This method is just here to be overwritten by you
    # unsurprisingly it's where all the content you want your slot to have goes
    def content
    end

    # redirecting unknown method calls to the shoes app so our gui methods work
    def method_missing(symbol, *args, &blk)
      @slot.app.send(symbol, *args, &blk)
    end

    class << self

      # setup given the slot where the tab content should be displayed
      def setup(slot)
        @loaded_tabs = {}
        @slot = slot
      end

      def open(tab, *args)
        @current_tab.close unless @current_tab.nil?
        @current_tab = get_tab(tab, *args)
        @current_tab.open *args
      end

      private

      def get_tab(tab_class, *args)
        if @loaded_tabs.include?(tab_class)
          return @loaded_tabs[tab_class]
        else
          # load the class responding to the symbol(the desired tab)
          # the class could also be required just here, what do you think?
          @loaded_tabs[tab_class] = tab_class.new(@slot, *args)
        end
      end

    end

  end
end

