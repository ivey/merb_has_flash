module MerbHasFlash
  module ControllerExtension
    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval { after :sweep_flash }
    end

    module InstanceMethods

      def flash(refresh = false) #:doc:
        session['flash'] = FlashHash.new unless refresh || session['flash'].is_a?(FlashHash)
        session['flash']
      end

    protected
      def sweep_flash
        flash.sweep
      end
    end
  end
end
