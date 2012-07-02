module ShoesSlotManager
  class SlotManager
    # setup given the slot where the tab content should be displayed
    def initialize(slot)
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
        # load the class responding to the Constant(the desired tab)
        @loaded_tabs[tab_class] = tab_class.new(@slot, self, *args)
      end
    end
  end
end
