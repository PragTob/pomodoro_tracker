module PomodoroTracker
  class TodayTab < SideTab

    def init_data
      @today ||= Day.today
    end

    def content
      para "This is your todo list for today"

      @today.activities.each{|activity| today_activity activity}

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
        @today.do_another_day activity
      end
    end

  end
end

