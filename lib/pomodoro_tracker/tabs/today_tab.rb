module PomodoroTracker
  class TodayTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot
    
    # dynamic is not totally right, we don't get new data but we have to
    # render the content once again (reset) since we need to update it TODO

    def init_data(activity_inventory = nil, options = nil)
      @activity_inventory ||= activity_inventory
      @options            ||= options
    end

    def content
      title "This is your todo list for today"

      table_slot = stack
      @activity_table = ActivityTableSlot.new table_slot,
                                              @slot_manager,
                                              @options,
                                              @activity_inventory.todo_today,
                                              @activity_inventory,
                                              [:start, :do_another_day, :finish]

      para "You might want to add something from your activity inventory"
    end

  end
end

