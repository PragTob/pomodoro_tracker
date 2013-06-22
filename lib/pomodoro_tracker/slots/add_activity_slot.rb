module PomodoroTracker
  class AddActivitySlot < ShoesSlotManager::Slot

    ENTER = "\n"

    def init_data(activity_inventory, activity_table = nil)
      @activity_inventory =  activity_inventory
      @activity_table = activity_table
    end

    def content
      stack do
        empty_line
        para "Add an activity to your activity backlog"
        add_activity_description
        add_activity_estimation
        button "Add" do add_activity end
      end
      keypress_handler
    end

    private

    def empty_line
      para
    end

    def add_activity_description
      flow do
        para "Description: "
        @description = edit_line
      end
    end

    def add_activity_estimation
      flow do
        para "Estimation: "
        @estimate = edit_line
      end
    end

    def add_activity
      # '' is converted to 0 when calling to_i so empty works just fine
      activity = Activity.new(description: @description.text,
                              estimate: @estimate.text.to_i)
      @activity_inventory.add activity
      @activity_table.new_activity(activity) if @activity_table
      @description.text = ''
      @estimate.text = ''
    end

    def keypress_handler
      keypress do |key|
        add_activity unless @description.text.empty? if key == ENTER
      end
    end
  end
end