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
      @activity_table = ActivityTableSlot.new table_slot,
                                              @slot_manager,
                                              @activity_inventory.todo_today,
                                              @activity_inventory,
                                              [:start, :do_another_day]

      para "You might want to add something from your activity inventory"
    end

  end
end

