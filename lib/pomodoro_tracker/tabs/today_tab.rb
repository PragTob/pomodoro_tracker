module PomodoroTracker
  class TodayTab < SideTab
    include DynamicSideTab

    def init_data(activity_inventory)
      @today ||= Day.today
      @activity_inventory = activity_inventory
    end

    def content
      para "This is your todo list for today"

      @activity_inventory.todo_today.each do |activity| 
        today_activity activity
      end

      para "You might want to add something from your activity inventory"
    end

    private
    def today_activity(activity)
      flow do
        para activity.description
        start_button activity
        do_another_day_button activity
      end
    end

    def start_button(activity)
      button 'Start' do
        activity.start
        SideTab.open PomodoroRunning, activity
      end
    end

    def do_another_day_button(activity)
      button 'Do another day' do
        activity.do_another_day
      end
    end

  end
end

