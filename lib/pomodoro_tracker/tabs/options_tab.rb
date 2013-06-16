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
        Options::OPTIONS.each do |option|
          setter_name = Options.setter_name_from option
          @options.send(setter_name, @option_edit_lines[option].text.to_i)
        end
      end
    end

    def description_from(option)
      option.to_s.gsub('_', ' ').capitalize
    end
  end
end