MENU_WIDTH = 120

# the main menu displayed on the left hand side
# opens the specified content in the main window
# find the corresponding classes in the tabs directory
def menu
  stack width: MENU_WIDTH do
    # TODO Why doesn't para link work? o_O
    button "Home" do
      PomodoroTracker::SideTab.open PomodoroTracker::Home
    end
    button "Inventory" do
      PomodoroTracker::SideTab.open PomodoroTracker::ActivityInventoryTab, @inventory
    end
    button 'ToDo Today' do
      PomodoroTracker::SideTab.open PomodoroTracker::TodayTab, @inventory
    end
    button "Close" do close if confirm "Are you sure?" end
  end
end

def boot
  @inventory = PomodoroTracker::ActivityInventory.new
end

# main app
Shoes.app title: "pomodoro tracker", width: 500, height: 600 do
  boot
  title "Pomodoros track you must", :align => "center"
  flow do
    menu
    @main_content = stack width: -MENU_WIDTH
  end

  PomodoroTracker::SideTab.setup(@main_content)
  # we start at home!
  PomodoroTracker::SideTab.open(PomodoroTracker::Home)
end

