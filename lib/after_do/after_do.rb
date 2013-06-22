# This is just a playground to inject behaviour without changing the class
# the behaviour is injected to.
# E.g. it shall be used in the Pomodoro Tracker for persistance

module AfterDo
  ALIAS_PREFIX = '__after_do_orig_'

  def _after_do_callbacks
    @_after_do_callbacks
  end

  def after(*methods, &block)
    @_after_do_callbacks ||= Hash.new([])
    if methods.empty?
      raise ArgumentError, 'after takes at least one method name!'
    end
    methods.each do |method|
      aliased_name = alias_name method
      if !private_method_defined? aliased_name
        @_after_do_callbacks[method] = []
        rename_old_method(method, aliased_name)
        redefine_method_with_callback(aliased_name, method)
      end
      @_after_do_callbacks[method] << block
    end
  end

  def remove_all_callbacks
    if @_after_do_callbacks
      @_after_do_callbacks.keys.each do |key| @_after_do_callbacks[key] = [] end
    end
  end

  private
  def alias_name(symbol)
    (ALIAS_PREFIX + symbol.to_s).to_sym
  end

  def rename_old_method(old_name, new_name)
    class_eval do
      alias_method new_name, old_name
      private new_name
    end
  end

  def redefine_method_with_callback(aliased_name, method)
    class_eval do
      define_method method do |*args|
        return_value = send(aliased_name, *args)
        self.class._after_do_callbacks[method].each do |block|
          block.call *args, self
        end
        return_value
      end
    end
  end
end