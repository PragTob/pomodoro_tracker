require 'simplecov'
SimpleCov.start

require 'factory_girl'
require 'timecop'
require 'after_do'

module PomodoroTracker
  # when require_relative does not work... - rspec version
  POMODORO_DIR = File.expand_path('../../lib/pomodoro_tracker', __FILE__) + '/'
end

require_relative '../lib/pomodoro_tracker/models/all'
require_relative 'pomodoro_tracker/factories'

