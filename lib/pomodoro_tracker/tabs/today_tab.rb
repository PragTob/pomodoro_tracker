module PomodoroTracker
  class TodayTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    
    # dynamic is not totally right, we don't get new data but we have to
    # render the content once again (reset) since we need to update it TODO

    def init_data(activity_inventory = nil)
      @today ||= Day.today
      @activity_inventory ||= activity_inventory
    end

    def content
      title "This is your todo list for today"

      table_slot = stack
      actions_block = Proc.new do |activity|
        start_button activity
        do_another_day_button activity
      end
      @activity_table = ActivityTableSlot.new table_slot,
                                              @activity_inventory.todo_today,
                                              actions_block

      para "You might want to add something from your activity inventory"
    end

    private
    def start_button(activity)
      button 'Start' do
        activity.start
        @slot_manager.open PomodoroRunningTab, activity
      end
    end

    def do_another_day_button(activity)
      button 'Do another day' do |do_another_day_button|
        activity.do_another_day
        do_another_day_button.parent.parent.remove
      end
    end

  end
end

