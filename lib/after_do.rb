module AfterDo
  # when require_relative does not work..."
  AFTER_DO_DIR = File.expand_path('../after_do/', __FILE__) + '/'
end

require AfterDo::AFTER_DO_DIR + 'after_do'