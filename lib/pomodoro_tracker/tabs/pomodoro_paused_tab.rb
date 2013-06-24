module PomodoroTracker
  class PomodoroPausedTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    include ClockHelper
    
    def init_data(activity, activity_inventory, options)
      @activity           = activity
      @activity_inventory = activity_inventory
      @options            = options
    end
    
    def content
      init_clock(pause_time) { display_pause_end }
      @info = para pause_info
      @quick = stack do
        resume_work_button unless @activity.finished?
        AddActivitySlot.new stack, @activity_inventory
      end

    end

    private
    def pause_time
      if time_for_extended_pause?
        @options.extended_pause_time
      else
        @options.normal_pause_time
      end
    end

    def time_for_extended_pause?
      (@activity.pomodori % 3) == 0
    end

    def pause_info
      "You shouldn't be reading this right now! " + 
      "It's time for a break and therefore you should step aways from the " +
      "keyboard and enjoy your break!"
    end
    
    def display_pause_end
      @quick.hide
      @info.replace pause_end_info
      @content.append do
        if @activity.finished?
          todo_today_button
        else
          resume_work_button
        end
      end
    end
    
    def pause_end_info
      'That was your break - hope you enjoyed! Time to get back to work again!'
    end

    def todo_today_button
      button 'Go back to Todo Today' do
        @slot_manager.open TodayTab, @activity_inventory
      end
    end
    
    def resume_work_button
      button 'Resume Work' do
        @slot_manager.open PomodoroRunningTab, @activity
      end
    end
    
  end

end
