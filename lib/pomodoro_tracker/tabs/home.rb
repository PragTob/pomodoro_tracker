module PomodoroTracker
  class Home < SideTab
    def content
      para "Hello world!"
      button "Start Pomodoro" do SideTab.open(PomodoroRunning) end
    end
  end
end

