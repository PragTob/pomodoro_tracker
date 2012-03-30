module PomodoroTracker
  class ActivityInventoryTab < SideTab

    def init_data
      @today ||= Day.today
      @activity_inventory ||= ActivityInventory.new
    end

    def content
      para "Activity Inventory"

      @activities = stack do
        @activity_inventory.each{ |activity| new_activity(activity) }
      end

      add_activity
    end

    private
    def add_today_button(activity)
      if @today.include? activity
        para "Already included in ToDo today"
      else
        button "Add to ToDoToday" do
          @today.add activity
        end
      end
    end

    def delete_button(activity)
      button "Delete" do
        @activity_inventory.remove activity
        reset
      end
    end

    def new_activity(activity)
      flow do
        para activity.description
        add_today_button(activity)
        delete_button(activity)
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

