MENU_WIDTH = 120

# the main menu displayed on the left hand side
# opens the specified content in the main window
# find the corresponding classes in the tabs directory
def menu
  stack width: MENU_WIDTH do
    # TODO Why doesn't para link work? o_O
    button "Home" do
      PomodoroTracker::SideTab.open PomodoroTracker::HomeTab
    end
    button "Inventory" do open_inventory end
    button 'ToDo Today' do open_today end
    button "Close" do close_pomodoro  end
  end
end

def open_inventory
  PomodoroTracker::SideTab.open PomodoroTracker::ActivityInventoryTab, @inventory
end

def open_today
  PomodoroTracker::SideTab.open PomodoroTracker::TodayTab, @inventory
end

def close_pomodoro
  close if confirm "Are you sure?"
end

def boot
  @inventory = PomodoroTracker::ActivityInventory.new
end

def general_key_handlers
  keypress do |key|
    open_inventory if key == :control_i
    open_today if key == :control_t
    close_pomodoro if key == :control_q
  end
end

# main app
Shoes.app title: "pomodoro tracker", width: 500, height: 600 do
  boot
  title "Pomodoros track you must", :align => "center"
  flow do
    menu
    @main_content = stack width: -MENU_WIDTH
  end
  
  general_key_handlers

  PomodoroTracker::SideTab.setup(@main_content)
  # we start at home!
  PomodoroTracker::SideTab.open(PomodoroTracker::HomeTab)
end

