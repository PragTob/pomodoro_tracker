module PomodoroTracker
  # when require_relative does not work..."
  LIB_DIR = File.expand_path('../pomodoro_tracker/', __FILE__) + '/'
  debug LIB_DIR
end

require PomodoroTracker::LIB_DIR + 'models/all'
require PomodoroTracker::LIB_DIR + 'side_tab'
require PomodoroTracker::LIB_DIR + 'dynamic_side_tab'
require PomodoroTracker::LIB_DIR + 'tabs/all'
require PomodoroTracker::LIB_DIR + 'main_window'

