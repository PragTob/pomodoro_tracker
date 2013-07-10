module PomodoroTracker
  class ActivityTableSlot < ShoesSlotManager::Slot

    TABLE_COLUMNS     = ['Description', 'Pomodori', 'Estimate', 'Actions']
    DESCRIPTION_WIDTH = 300
    POMODORI_WIDTH = ESTIMATE_WIDTH = 100
    ACTIONS_WIDTH     = 300
    DESCRIPTION_LEFT  = MENU_WIDTH

    POMODORI_LEFT = DESCRIPTION_LEFT + DESCRIPTION_WIDTH
    ESTIMATE_LEFT = POMODORI_LEFT + POMODORI_WIDTH
    ACTIONS_LEFT  = ESTIMATE_LEFT + ESTIMATE_WIDTH

    START_BUTTON          = :start
    DO_TODAY_BUTTON       = :do_today
    DO_ANOTHER_DAY_BUTTON = :do_another_day
    DELETE_BUTTON         = :delete
    RESURRECT_BUTTON      = :resurrect
    FINISH_BUTTON         = :finish



    # activities - the activities to be displayed
    # activity_inventory - the activity inventory needed to make changes to
    #                      activities save to the DB
    # buttons - array with symbols for buttons to be used
    def init_data(slot_manager = nil, options = nil, activities, activity_inventory, buttons)
      @slot_manager       = slot_manager
      @options            = options
      @activities         = activities
      @activity_inventory = activity_inventory
      @buttons            = buttons
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
        actions_column(activity)
      end
    end

    def actions_column(activity)
      flow width: ACTIONS_WIDTH do
        start_button(activity) if @buttons.include? START_BUTTON
        do_another_day_button(activity) if @buttons.include? DO_ANOTHER_DAY_BUTTON
        do_today_button(activity) if @buttons.include? DO_TODAY_BUTTON
        resurrect_button(activity) if @buttons.include? RESURRECT_BUTTON
        delete_button(activity) if @buttons.include? DELETE_BUTTON
        finish_button(activity) if @buttons.include? FINISH_BUTTON
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

    private
    def start_button(activity)
      button 'Start' do
        activity.start
        @slot_manager.open PomodoroRunningTab, activity,
                                               @activity_inventory,
                                               @options
      end
    end

    def do_another_day_button(activity)
      button 'Do another day' do |do_another_day_button|
        activity.do_another_day
        remove_row_of do_another_day_button
      end
    end

    def do_today_button(activity)
      button "Do Today" do |do_today_button|
        activity.do_today
        remove_row_of do_today_button
      end
    end

    def delete_button(activity)
      button "Delete" do |delete_button|
        if confirm 'Sure to delete this activity?'
          @activity_inventory.remove activity
          remove_row_of delete_button
        end
      end
    end

    def resurrect_button(activity)
      button 'Resurrect' do |resurrect_button|
        activity.resurrect
        remove_row_of resurrect_button
      end
    end

    def finish_button(activity)
      button 'Finish' do |finish_button|
        activity.finish
        remove_row_of finish_button
      end
    end

    def remove_row_of(element)
      element.parent.parent.remove
    end
  end
end