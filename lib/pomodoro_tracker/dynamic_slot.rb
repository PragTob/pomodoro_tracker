module ShoesSlotManager
  # A slot that totally resets it contents and inits itself with new data
  # every time it is opened
  module DynamicSlot

    def init_slot
      @slot.append{ @content = stack do;end }
    end

    # ocerwrite the old content
    def open(*args)
      init_data(*args)
      @slot.append do
        @content = stack do content end
      end
    end

    def close
      clear
    end

  end
end

