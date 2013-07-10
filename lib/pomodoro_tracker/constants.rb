# these constants are needed by some tabs but actually they should go into the
# main window. But the main window has to be loaded last.
module PomodoroTracker
  MENU_WIDTH = 100
  BUTTON_WIDTH = MENU_WIDTH - 10
  OPTIONS_LOCATION = File.expand_path('../../..', __FILE__) + '/options.yml'
end