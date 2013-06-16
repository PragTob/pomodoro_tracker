module PomodoroTracker
  class OptionsTab < ShoesSlotManager::ManageableSlot
    def init_data(options)
      @options = options
    end

    def content
      stack do
        flow do
          para 'Pomodoro time'
          @pomodoro_time = edit_line @options.pomodoro_time
        end
        flow do
          para 'Normal pause time'
          @normal_pause_time = edit_line @options.normal_pause_time
        end
        flow do
          para 'Extended pause time'
          @extended_pause_time = edit_line @options.extended_pause_time
        end
        button 'Save' do
          @options.pomodoro_time       = @pomodoro_time.text.to_i
          @options.normal_pause_time   = @normal_pause_time.text.to_i
          @options.extended_pause_time = @extended_pause_time.text.to_i
        end
      end
    end
  end
end