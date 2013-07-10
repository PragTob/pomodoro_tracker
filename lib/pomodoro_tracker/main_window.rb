module PomodoroTracker

  Shoes.app title: "pomodoro tracker", width: 940, height: 800 do
    # the main menu displayed on the left hand side
    # opens the specified content in the main window
    # find the corresponding classes in the tabs directory
    def menu
      stack width: MENU_WIDTH do
        # TODO Why doesn't para link work? o_O
        button 'ToDo Today', width: BUTTON_WIDTH do open_today end
        button 'Inventory', width: BUTTON_WIDTH do open_inventory end
        button 'Finished', width: BUTTON_WIDTH do open_finished end
        button 'Options', width: BUTTON_WIDTH do open_options end
        button 'Close', width: BUTTON_WIDTH do close_pomodoro  end
      end
    end

    def boot
      @options = Options.new OPTIONS_LOCATION
      load_activity_inventory
    end

    def load_activity_inventory
      persistor  = FilePersistor.new @options.activities_storage_path
      @inventory = ActivityInventory.new persistor
    end

    def open_inventory
      @slot_manager.open ActivityInventoryTab, @inventory
    end

    def open_today
      @slot_manager.open TodayTab, @inventory, @options
    end

    def open_finished
      @slot_manager.open FinishedActivitiesTab, @inventory
    end

    def open_options
      @slot_manager.open OptionsTab, @options
    end

    def close_pomodoro
      close if confirm "Are you sure?"
    end

    def general_key_handlers
      keypress do |key|
        case key
          when :control_i then open_inventory
          when :control_t then open_today
          when :control_q then close_pomodoro
        end
      end
    end

    boot
    title "Pomodoros track you must", :align => "center"
    flow do
      menu
      @main_content = stack width: -MENU_WIDTH
    end

    general_key_handlers

    @slot_manager = ShoesSlotManager::SlotManager.new(@main_content)
    # we start at home!
    open_today
  end
end

