module PomodoroTracker
  class ActivityTableSlot < ShoesSlotManager::Slot

    TABLE_COLUMNS     = ['Description', 'Pomodori', 'Estimate', 'Actions']
    DESCRIPTION_WIDTH = POMODORI_WIDTH = ESTIMATE_WIDTH = 100
    ACTIONS_WIDTH     = 180
    DESCRIPTION_LEFT  = ::MENU_WIDTH

    POMODORI_LEFT = DESCRIPTION_LEFT + DESCRIPTION_WIDTH
    ESTIMATE_LEFT = POMODORI_LEFT + POMODORI_WIDTH
    ACTIONS_LEFT  = ESTIMATE_LEFT + ESTIMATE_WIDTH


    def init_data(activities, actions_block)
      @activities     = activities
      @actions_block  = actions_block
    end

    def content
      table_header
      @activities_table = stack do
        @activities.each{ |activity| new_activity_column(activity) }
      end
    end

    def table_header
      flow do
        TABLE_COLUMNS.each do |column_name|
          left_value = self.class.const_get(column_name.upcase + '_LEFT')
          para strong(column_name), left:left_value
        end
        debug 'muhhh'
      end
    end

    def new_activity(activity)
      @activities_table.append do new_activity_column(activity) end
    end

    def new_activity_column(activity)
      flow do
        TABLE_COLUMNS[0..-2].each do |column_name|
          activity_column activity, column_name
        end
        # actions column is kind of special
        flow width: ACTIONS_WIDTH do
          @actions_block.call activity
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

  end
end