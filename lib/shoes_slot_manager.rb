module ShoesSlotManager
  # when require_relative does not work..."
  SLOT_DIR = File.expand_path('../shoes_slot_manager/', __FILE__) + '/'
end

require ShoesSlotManager::SLOT_DIR + 'slot'
require ShoesSlotManager::SLOT_DIR + 'dynamic_slot'
require ShoesSlotManager::SLOT_DIR + 'slot_manager'