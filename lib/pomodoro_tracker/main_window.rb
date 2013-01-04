module PomodoroTrack

  STORAGE_LOCATION = File.expand_path('../../..', __FILE__) + '/store.pstore'
  puts STORAGE_LOCATION

  Shoes.app title: "pomodoro tracker", width: 600, height: 600 do
    # the main menu displayed on the left hand side
    # opens the specified content in the main window
    # find the corresponding classes in the tabs directory
    def menu
      stack width: MENU_WIDTH do
        # TODO Why doesn't para link work? o_O
        button 'ToDo Today', width: BUTTON_WIDTH do open_today end
        button 'Inventory', width: BUTTON_WIDTH do open_inventory end
        button 'Close', width: BUTTON_WIDTH do close_pomodoro  end
      end
    end

    def boot
      persistor  = PomodoroTracker::FilePersistor.new STORAGE_LOCATION
      @inventory = PomodoroTracker::ActivityInventory.new persistor
    end

    def open_inventory
      @slot_manager.open PomodoroTracker::ActivityInventoryTab, @inventory
    end

    def open_today
      @slot_manager.open PomodoroTracker::TodayTab, @inventory
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

