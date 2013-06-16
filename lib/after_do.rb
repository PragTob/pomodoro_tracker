module AfterDo
  # when require_relative does not work..."
  AFTER_DO_DIR = File.expand_path('../shoes_slot_manager/', __FILE__) + '/'
end

require AfterDo::AFTER_DO_DIR + 'after_do'