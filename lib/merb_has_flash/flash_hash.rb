module MerbHasFlash
  class FlashNow #:nodoc:
    def initialize(flash)
      @flash = flash
    end

    def []=(key, val)
      @flash[key] = val
      @flash.discard key
      val
    end

    def [](key)
      @flash[key]
    end
  end

  class FlashHash
    def initialize(*args) #:nodoc:
      @attrs = Hash.new(*args)
      @keepers = []
    end

    def []=(key, val) #:nodoc:
      @attrs[key] = val
      keep key
    end

    def [](key)
      @attrs[key]
    end

    def update(hash) #:nodoc:
      @attrs.update hash
      hash.keys.each { |key| keep key }
    end

    alias :merge! :update

    def replace(hash) #:nodoc:
      @attrs.replace hash
      keep  # keep with no args automatically clears out unused keys and keeps all used ones.
    end

    def method_missing(method_name, *args, &block) #:nodoc:
      @attrs.send(method_name, *args, &block)
    end

    # Sets a flash that will not be available to the next action, only to the current.
    #
    #     flash.now[:message] = "Hello current action"
    #
    # This method enables you to use the flash as a central messaging system in your app.
    # When you need to pass an object to the next action, you use the standard flash assign (<tt>[]=</tt>).
    # When you need to pass an object to the current action, you use <tt>now</tt>, and your object will
    # vanish when the current action is done.
    #
    # Entries set via <tt>now</tt> are accessed the same way as standard entries: <tt>flash['my-key']</tt>.
    def now
      @_fn ||= FlashNow.new self  # This way, a new object is not created on every "now."
    end

    # Keeps either the entire current flash or a specific flash entry available for the next action:
    #
    #    flash.keep            # keeps the entire flash
    #    flash.keep(:notice)   # keeps only the "notice" entry
    def keep(key = nil)
      key.nil? ? @keepers = @attrs.keys : @keepers << key unless @keepers.include?(key)
    end

    # Marks the entire flash or a single flash entry to be discarded by the end of the current action
    #
    #     flash.discard              # discard the entire hash (it'll still be available for the current action)
    #     flash.discard(:warning)    # discard the "warning" entry (still available as above)
    def discard(key = nil)
      key.nil? ? @keepers = [] : @keepers.delete(key)
    end

    # Clear the keys that are kept, and delete the ones that are currently unkept
    # This method is called automatically by filters, so you generally don't need to care about it.
    def sweep #:nodoc:
      @attrs.keys.each { |key| @attrs.delete key unless @keepers.include?(key) }
      discard
    end

  end

end
