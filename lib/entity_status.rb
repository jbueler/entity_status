class Object
  # GIVES US THE ABILITY TO ADD DYNMAIC CLASS METHODS TO THE STATUSES MODULE....
  # http://ryanangilly.com/post/234897271/dynamically-adding-class-methods-in-ruby
  def metaclass
    class << self; self; end
  end
end

module EntityStatus
  extend ActiveSupport::Concern
  module ClassMethods
    def entity_status(*statuses)
      statuses = (statuses.count > 0) ? statuses : %W(pending open closed)
      statuses.each do |st|
        self.create_method(st)
        
        # add dynamic state setters based on the status string
        # example: Post.first.pending #=> 'pending'
        define_method st do
          self.status = st
          self
        end
    
        # Add boolean state checks based on the status string
        # example: Post.first.pending? #=> true
        define_method "#{st}?" do
          (self.state == st) ? true :false
        end
      end
      
    end
    def create_method(name)
      klass = self.to_s
      metaclass.instance_eval do
        define_method(name){
          where(status: name)
        }
      end
    end
  end

  module InstanceMethods
    def state
      self.status
    end

    def dependant_state_update(state)
      self.update_attributes status: state
      self.reflections.each do |rel|
        if rel.last.klass.method_defined? :dependant_state_update
          if rel.last.options[:dependent] == :destroy
            items = [] + self.send(rel.last.name)
            items.each do |item|
              item.dependant_state_update state
            end
          end
        end
      end
    end
    
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
    receiver.entity_status if receiver.respond_to? :entity_status
      
    if receiver.method_defined?(:attr_accessible)
      receiver.attr_accessible :status
      # receiver.after_create :default_status
    end
  end
end