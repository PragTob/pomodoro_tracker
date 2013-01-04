module PomodoroTracker
  class TodayTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    
    # dynamic is not totally right, we don't get new data but we have to
    # render the content once again (reset) since we need to update it TODO

    def init_data(activity_inventory = nil)
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
        @activity_inventory.change_activity(activity) do |activity|
          activity.start
        end
        @slot_manager.open PomodoroRunningTab, activity, @activity_inventory
      end
    end

    def do_another_day_button(activity)
      button 'Do another day' do |do_another_day_button|
        @activity_inventory.change_activity(activity) do |activity|
          activity.do_another_day
        end
        do_another_day_button.parent.parent.remove
      end
    end

  end
end

