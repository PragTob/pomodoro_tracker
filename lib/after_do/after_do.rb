# This is just a playground to inject behaviour without changing the class
# the behaviour is injected to.
# E.g. it shall be used in the Pomodoro Tracker for persistance

module AfterDo
  ALIAS_PREFIX = 'orig_'
  #def self.extended(klass)
  #  @
  #end

  def after(method, &block)
    aliased_name = alias_name method
    rename_old_method(method, aliased_name)
    redefine_method_with_callback(aliased_name, method, block)
  end

  private
  def alias_name(symbol)
    (ALIAS_PREFIX + symbol.to_s).to_sym
  end

  def rename_old_method(old_name, new_name)
    singleton_class.class_eval do
      alias_method new_name, old_name
    end
  end

  def redefine_method_with_callback(aliased_name, method, block)
    define_singleton_method method do |*args|
      return_value = send(aliased_name, *args)
      block.call
      return_value
    end
  end
end