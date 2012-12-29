module PomodoroTracker
  class ActivityInventoryTab < ShoesSlotManager::Slot
    include ShoesSlotManager::DynamicSlot

    TABLE_COLUMNS     = ['Description', 'Pomodori', 'Estimate', 'Actions']
    DESCRIPTION_WIDTH = POMODORI_WIDTH = ESTIMATE_WIDTH = 100
    ACTIONS_WIDTH     = 180
    DESCRIPTION_LEFT  = ::MENU_WIDTH

    POMODORI_LEFT = DESCRIPTION_LEFT + DESCRIPTION_WIDTH
    ESTIMATE_LEFT = POMODORI_LEFT + POMODORI_WIDTH
    ACTIONS_LEFT  = ESTIMATE_LEFT + ESTIMATE_WIDTH

    ENTER = "\n"

    def init_data(inventory = nil)
      @activity_inventory ||= inventory
    end

    def content
      title "Activity Inventory"

      table_header
      @activities = stack do
        @activity_inventory.backlog.each{ |activity| new_activity(activity) }
      end

      add_activity_section
    end

    private

    def table_header
      flow do
        TABLE_COLUMNS.each do |column_name|
          left_value = self.class.const_get(column_name.upcase + '_LEFT')
          para strong(column_name), left:left_value
        end
      end
    end

    def do_today_button(activity)
      button "Do Today" do |add_button|
        activity.do_today
        add_button.parent.parent.remove
      end
    end

    def delete_button(activity)
      button "Delete" do |delete_button|
        if confirm 'Sure to delete this activity?'
          @activity_inventory.remove activity
          delete_button.parent.parent.remove
        end
      end
    end

    def new_activity(activity)
      flow do
        TABLE_COLUMNS[0..-2].each do |column_name|
          activity_column activity, column_name
        end
        # actions column is kind of special
        flow width: ACTIONS_WIDTH do
          do_today_button(activity)
          delete_button(activity)
        end
      end
    end

    def activity_column activity, column_name
      flow width: column_width(column_name) do
        para activity.send(column_name.downcase)
      end
    end

    def column_width(column_name)
      self.class.const_get((column_name.upcase + "_WIDTH").to_sym)
    end

    def add_activity_section
      stack do
        para "Add an activity"
        add_activity_description
        add_activity_estimation
        button "Add" do add_activity end
      end
      keypress_handler
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
      @activities.append { new_activity(activity) }
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

