module PomodoroTracker
  # when require_relative does not work..."
  LIB_DIR      = File.expand_path('../', __FILE__) + '/'
  POMODORO_DIR = LIB_DIR + 'pomodoro_tracker/'
end

require PomodoroTracker::LIB_DIR      + 'shoes_slot_manager'
require PomodoroTracker::LIB_DIR      + 'after_do'
require PomodoroTracker::POMODORO_DIR + 'constants'
require PomodoroTracker::POMODORO_DIR + 'models/all'
require PomodoroTracker::POMODORO_DIR + 'tabs/all'
require PomodoroTracker::POMODORO_DIR + 'slots/activity_table_slot'
require PomodoroTracker::POMODORO_DIR + 'main_window'

