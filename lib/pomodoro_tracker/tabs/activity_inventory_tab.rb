module PomodoroTracker
  class ActivityInventoryTab < SideTab

    def content
      para "Activity Inventory"
      @activity_inventory ||= ActivityInventory.new

      @activities = stack do
        @activity_inventory.each { |activity| new_activity(activity) }
      end

      add_activity
    end

    private
    def new_activity(activity)
      flow do
        para activity.description
      end
    end

    def add_activity
      stack do
        para "Add an activity"
        flow do
          @edit_line = edit_line
          button "Add" do
            activity = Activity.new(@edit_line.text)
            @activity_inventory.add activity
            @activities.append { new_activity(activity) }
          end
        end
      end
    end

  end
end

