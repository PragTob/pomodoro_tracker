module ShoesSlotManager
  # A slot that totally resets it contents and inits itself with new data
  # every time it is opened
  module DynamicSlot

    def init_slot
    end

    # overwrite the old content
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

