module PomodoroTracker
  class OptionsTab < ShoesSlotManager::ManageableSlot
    def init_data(options)
      @options = options
      @option_edit_lines = {}
    end

    def content
      stack do
        option_edit_lines
        save_button()
      end
    end

    private
    def option_edit_lines
      Options::OPTIONS.each do |option|
        para description_from(option)
        @option_edit_lines[option] = edit_line @options.send(option)
      end
    end

    def save_button
      button 'Save' do
        old_activity_storage_path = @options.activities_storage_path
        Options::OPTIONS.each do |option|
          setter_name = Options.setter_name_from option
          input = @option_edit_lines[option].text
          input = input.to_i if Options::INTEGER_OPTIONS.include? option
          @options.send(setter_name, input)
        end
        restart_notice if storage_path_changed?(old_activity_storage_path)
      end
    end

    def storage_path_changed?(old_path)
      @options.activities_storage_path != old_path
    end

    def restart_notice
      alert 'The activity storage path seems to have changed! Please restart ' +
            'the Pomodoro Tracker for the changes to take effect!'
    end

    def description_from(option)
      option.to_s.gsub('_', ' ').capitalize
    end
  end
end