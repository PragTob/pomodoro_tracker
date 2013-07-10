module PomodoroTracker
  options = Options.new OPTIONS_LOCATION
  persistor  = FilePersistor.new options.activities_storage_path
  Activity.extend AfterDo
  Activity.after :start, :pause, :finish, :resurrect,
                 :do_today, :do_another_day do |activity|
    persistor.save activity
  end
end