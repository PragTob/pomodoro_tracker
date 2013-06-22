module PomodoroTracker
  class PomodoroRunningTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    include ClockHelper

    # the default argument is necessary so we don't have to pass
    # @activity_inventory over to the paused tab.
    # This tab should always be opened before the paused tab so that's no prob
    def init_data(activity, activity_inventory = nil, options = nil)
      @activity           =   activity
      @activity_inventory ||= activity_inventory
      @options            ||= options
    end

    def content
      init_clock(@options.pomodoro_time) { display_pomodoro_end }
      para working_info
      @quick = stack do
        quick_finish
        AddActivitySlot.new stack, @activity_inventory
      end

    end

    private
    def display_pomodoro_end
      @quick.hide
      @content.append do
        @end_buttons = flow do
          finish_button 'Finish'
          pause_button
        end
      end
    end
    
    def finish_button(label)
      button label do
        @activity.finish
        @slot_manager.open PomodoroTracker::TodayTab
      end
    end
    
    def pause_button
      button "Pause" do
        @activity.pause
        @slot_manager.open PomodoroPausedTab, @activity,
                                              @activity_inventory,
                                              @options
      end
    end

    def working_info
      "You are working on the activity '#{@activity.description}'. " +
      "You are already working on this activity for #{@activity.pomodori} pomodori. " +
      "You estimated that this activity would take you #{@activity.estimate} pomodori to finish."
    end

    def quick_finish
      finish_button 'Finish early'
    end

  end
end

