module ShoesSlotManager
  # slots/tabs as inspired by the original hacketyhack code
  class Slot

    def initialize(slot, *args)
      init_data(*args)
      @slot = slot
      init_slot
    end

    # may be overriden to provide some none UI initialization
    def init_data(*args)
    end

    # slot is the slot in which this slot should be displayed
    def init_slot
      @slot.append{ @content = stack{content} }
    end

    # This method is just here to be overwritten by you
    # unsurprisingly it's where all the content you want your slot to have goes
    def content
    end

    # redirecting unknown method calls to the shoes app so our gui methods work
    def method_missing(symbol, *args, &blk)
      @slot.app.send(symbol, *args, &blk) if app_should_handle_method? symbol
    end

    private
    def app_should_handle_method? method_name
      !self.respond_to?(method_name) && @slot.app.respond_to?(method_name)
    end

  end
end