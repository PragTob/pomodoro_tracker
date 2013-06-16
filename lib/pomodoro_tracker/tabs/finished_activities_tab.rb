module PomodoroTracker
  class FinishedActivitiesTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot

    def init_data(activity_inventory = nil)
      @activity_inventory ||= activity_inventory
    end

    def content
      title 'A list of activities you completed in the past.'

      table_slot = stack
      @activity_table = ActivityTableSlot.new table_slot,
                                              @slot_manager,
                                              @activity_inventory.finished,
                                              @activity_inventory,
                                              [:resurrect, :delete]
    end
  end
end