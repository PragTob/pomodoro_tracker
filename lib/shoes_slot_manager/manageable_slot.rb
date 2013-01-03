module ShoesSlotManager
  # Slots that can be managed by hiding and showing them
  # ideal to implement something like tabs
  # inspired by the hacketyhack code
  class ManageableSlot < Slot

    # slot_manager is the SlotManager handling the slot
    #   it can be used to display other slots 
    def initialize(slot, slot_manager, *args)
      @slot_manager = slot_manager
      super slot, *args
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

  end
end

