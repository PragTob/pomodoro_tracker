FactoryGirl.define do

  factory :activity, class: PomodoroTracker::Activity do
    description "A simple activity"
    estimate    1
    priority    0
  end

end

