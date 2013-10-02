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
    def entity_status(column_name="status",status_array = [])
      status_array = (status_array.count > 0) ? status_array : %W(pending open closed)
      self.create_statuses_method(column_name.to_s.pluralize,status_array)
      status_array.each do |st|
        self.create_finder_methods(column_name,st)
        
        # add dynamic state setters based on the status string
        # example: Post.first.pending #=> 'pending'
        define_method st do
          self.send("#{column_name}=".to_sym,st.to_s)
          self
        end
    
        # Add boolean state checks based on the status string
        # example: Post.first.pending? #=> true
        define_method "#{st}?" do
          (self.send(column_name) == st) ? true :false
        end
      end
      
    end

    def create_statuses_method(name,statuses)
      klass = self.to_s
      metaclass.instance_eval do
        # attr_accessor :statuses        
        # @@statuses = statuses
        define_method(name){
          return statuses
        }
      end
    end

    def create_finder_methods(column_name,name)
      klass = self.to_s
      metaclass.instance_eval do
        define_method(name){
          where(column_name.to_sym => name)
        }
      end
    end
    
  end

  module InstanceMethods
    def state
      self.status.to_s
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