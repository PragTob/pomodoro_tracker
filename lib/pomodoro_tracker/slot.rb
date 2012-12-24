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

    # slot is the slot in which this slot should be displayed
    # slot_manager is the SlotManager handling the slot
    #   it can be used to display other slots 
    def initialize(slot, slot_manager, *args)
      init_data(*args)
      @slot = slot
      @slot_manager = slot_manager
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
      @slot.app.send(symbol, *args, &blk) if @slot.app.respond_to? symbol
    end

  end
end

