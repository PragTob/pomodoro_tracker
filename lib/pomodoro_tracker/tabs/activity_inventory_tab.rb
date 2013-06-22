module PomodoroTracker
  class ActivityInventoryTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot

    def init_data(inventory = nil)
      @activity_inventory ||= inventory
    end

    def content
      title "Activity Inventory"

      @activity_table = ActivityTableSlot.new stack,
                                              @activity_inventory.backlog,
                                              @activity_inventory,
                                              [:do_today, :delete]

      AddActivitySlot.new stack,
                          @activity_inventory,
                          @activity_table
    end

  end
end

