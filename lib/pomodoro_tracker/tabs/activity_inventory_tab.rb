module PomodoroTracker
  class ActivityInventoryTab < SideTab
    include DynamicSideTab
    
    ENTER = "\n"

    def init_data(inventory = nil)
      @activity_inventory ||= inventory
    end

    def content
      para "Activity Inventory"

      @activities = stack do
        @activity_inventory.backlog.each{ |activity| new_activity(activity) }
      end

      add_activity_section
    end

    private
    def add_today_button(activity)
      button "Add to ToDoToday" do |add_button|
        activity.do_today
        add_button.parent.remove
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

    def add_activity_section
      stack do
        para "Add an activity"
        flow do
          @edit_line = edit_line
          button "Add" do add_activity end
        end
      end
      keypress_handler
    end

    def add_activity
      activity = Activity.new(@edit_line.text)
      @activity_inventory.add activity
      @activities.append { new_activity(activity) }
      @edit_line.text = ''
    end

    def keypress_handler
      keypress do |key|
        if key == ENTER
          add_activity unless @edit_line.text.empty?
        end
      end
    end

  end
end

