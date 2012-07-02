module PomodoroTracker
  # when require_relative does not work..."
  LIB_DIR = File.expand_path('../pomodoro_tracker/', __FILE__) + '/'
end

require PomodoroTracker::LIB_DIR + 'models/all'
require PomodoroTracker::LIB_DIR + 'slot'
require PomodoroTracker::LIB_DIR + 'slot_manager'
require PomodoroTracker::LIB_DIR + 'dynamic_slot'
require PomodoroTracker::LIB_DIR + 'tabs/all'
require PomodoroTracker::LIB_DIR + 'main_window'

