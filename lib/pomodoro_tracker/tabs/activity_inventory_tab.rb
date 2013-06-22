module PomodoroTracker
  class ActivityInventoryTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot

    def init_data(inventory = nil)
      @activity_inventory ||= inventory
    end

    def content
      title "Activity Inventory"

      table_slot = stack
      @activity_table = ActivityTableSlot.new table_slot,
                                              @activity_inventory.backlog,
                                              @activity_inventory,
                                              [:do_today, :delete]

      add_activity_slot = stack
      AddActivitySlot.new add_activity_slot,
                          @activity_inventory,
                          @activity_table
    end

  end
end

