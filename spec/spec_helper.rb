require 'factory_girl'
require 'timecop'

module PomodoroTracker
  # when require_relative does not work... - rspec version
  LIB_DIR = File.expand_path('../../lib/pomodoro_tracker', __FILE__) + '/'
  puts LIB_DIR
end

#require_relative '../lib/pomodoro_tracker/models/activity'
#require_relative '../lib/pomodoro_tracker/models/activity_inventory'
#require_relative '../lib/pomodoro_tracker/models/to_do_today'
require_relative '../lib/pomodoro_tracker/models/all'
require_relative 'factories'

