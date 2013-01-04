module PomodoroTracker
  class FinishedTab < ShoesSlotManager::ManageableSlot
    include ShoesSlotManager::DynamicSlot

    def init_data(activity_inventory = nil)
      @activity_inventory ||= activity_inventory
    end

    def content
      title "You have already completed all these activities"

      table_slot = stack
      @activity_table = ActivityTableSlot.new table_slot,
                                              @activity_inventory.finished,
                                              @activity_inventory,
                                              [:reanimate, :remove]

    end

  end
end

