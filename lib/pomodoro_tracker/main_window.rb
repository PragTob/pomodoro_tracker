MENU_WIDTH = 120

# the main menu displayed on the left hand side
# opens the specified content in the main window
# find the corresponding classes in the tabs directory
def menu
  stack width: MENU_WIDTH do
    para link("Home") { open_tab(PomodoroTracker::Home) }
    para link("Close") { close if confirm "Are you sure?" }
  end
end

# main app
Shoes.app title: "pomodoro tracker", width: 500, height: 300 do
  title "Pomodoros track you must", :align => "center"
  flow do
    menu
    @main_content = stack width: -MENU_WIDTH
  end

  PomodoroTracker::SideTab.setup(@main_content)
  # we start at home!
  PomodoroTracker::SideTab.open(PomodoroTracker::Home)
end

