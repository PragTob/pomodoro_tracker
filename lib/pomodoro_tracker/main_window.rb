MENU_WIDTH = 120

# the main menu displayed on the left hand side
# opens the specified content in the main window
# find the corresponding classes in the tabs directory
def menu
  stack width: MENU_WIDTH do
    para link("Home") { open_tab(Infoes::Home) }
    para link("Close") { close if confirm "Are you sure?" }
  end
end

def get_tab(tab_class)
  if @loaded_tabs.include?(tab_class)
    return @loaded_tabs[tab_class]
  else
    # load the class responding to the symbol(the desired tab)
    # the class could also be required just here, what do you think?
    @loaded_tabs[tab_class] = tab_class.new(@main_content)
  end
end

def open_tab(tab)
  @current_tab.close unless @current_tab.nil?
  @current_tab = get_tab(tab)
  @current_tab.open
end

# main app
Shoes.app title: "pomodoro tracker", width: 500, height: 300 do
  @loaded_tabs = {}
  title "Pomodoros track you must", :align => "center"
  flow do
    menu
    @main_content = stack width: -MENU_WIDTH
  end

  # we start at home!
  open_tab(PomodoroTracker::Home)
end

