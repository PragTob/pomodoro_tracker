module PomodoroTracker
  class Day

    attr_reader :date, :external_interruptions, :internal_interruptions,
                :activities

    def initialize
      @date = Date.today
      @internal_interruptions = 0
      @external_interruptions = 0
      @activities = Set.new
    end

    def internal_interrupt
      @internal_interruptions += 1
    end

    def external_interrupt
      @external_interruptions += 1
    end

    def add(activity)
      @activities << activity
    end

    def empty?
      @activities.empty?
    end

    def interruptions
      @external_interruptions + @internal_interruptions
    end

    def include?(activity)
      @activities.include? activity
    end
    
    def remove(activitiy)
      @activities.delete activitiy
    end
    
    alias_method :do_another_day, :remove

    class << self
      def today
        @today ||= self.new
      end
    end

  end
end

