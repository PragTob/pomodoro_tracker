require 'factory_girl'
require 'timecop'

module PomodoroTracker
  # when require_relative does not work... - rspec version
  POMODORO_DIR = File.expand_path('../../lib/pomodoro_tracker', __FILE__) + '/'
end

require_relative '../lib/pomodoro_tracker/models/all'
require_relative 'factories'

