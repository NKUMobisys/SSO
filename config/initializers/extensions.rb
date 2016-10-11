module ActionView
  module Helpers

    module FormHelper
      alias_method :_orig_form_for, :form_for
      def form_for(record, options = {}, &block)
        case record
        when String, Symbol
          object_name = record
          object      = nil
        else
          object      = record.is_a?(Array) ? record.last : record
          raise ArgumentError, "First argument in form cannot contain nil or be empty" unless object
          object_name = options[:as] || model_name_from_record_or_class(object).param_key
        end

        options[:html] ||= {}
        options[:html][:name] ||= "#{object_name}_form"
        options[:html][:"ng-submit"] ||= "handle_form_submit($event, '#{object_name}')"
        options[:builder] ||= CustomFormBuilder
        _orig_form_for(record, options, &block)
      end
    end

  end
end


module Rails
  module Generators
    class GeneratedAttribute # :nodoc:

      def datetime?
        [:time, :datetime].include? type
      end

    end
  end
end