# This is just a playground to inject behaviour without changing the class
# the behaviour is injected to.
# E.g. it shall be used in the Pomodoro Tracker for persistance

module AfterDo
  ALIAS_PREFIX = '__after_do_orig_'
  #def self.extended(klass)
  #  @
  #end

  def after(*methods, &block)
    if methods.empty?
      raise ArgumentError, 'after takes at least one method name!'
    end
    methods.each do |method|
      aliased_name = alias_name method
      rename_old_method(method, aliased_name)
      redefine_method_with_callback(aliased_name, method, block)
    end
  end

  private
  def alias_name(symbol)
    (ALIAS_PREFIX + symbol.to_s).to_sym
  end

  def rename_old_method(old_name, new_name)
    class_to_modify.class_eval do
      alias_method new_name, old_name
      private new_name
    end
  end

  def class_to_modify
    # if after is called on a class we want to modify all instances of that
    # class.
    # If it is called on a single object on the other hand, we just want to
    # modify that one object.
    if self.class == Class
      self
    else
      self.singleton_class
    end
  end

  def redefine_method_with_callback(aliased_name, method, block)
    class_to_modify.class_eval do
      define_method method do |*args|
        return_value = send(aliased_name, *args)
        block.call *args, self
        return_value
      end
    end
  end
end