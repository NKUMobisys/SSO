# http://stackoverflow.com/questions/22183500/how-to-extend-a-core-rails-formbuilder-field
class CustomFormBuilder < ActionView::Helpers::FormBuilder

  def ng_submit(value=nil, options={})
    value, options = nil, value if value.is_a?(Hash)
    value ||= submit_default_value
    @template.content_tag(:"md-button", value, {type: :submit, :class => "md-raised md-primary"})
  end

  def ng_select(attribute, options={})

    c_show = options.delete(:show) || "name"
    c_key = options.delete(:key) || "id"



    value = nil

    obj_class = @object.class


    c_klass = obj_class.reflections[attribute.to_s].klass
    c_item = c_klass.to_s.gsub("::", "_").downcase
    c_name = c_item.pluralize
    c_fk = obj_class.reflections[attribute.to_s].foreign_key
    object_attr = "#{object_name}.#{c_fk}"
    attr_value = @object[c_fk]


    md_seclet_opt = {
      type:     :submit, 
      class:    "md-raised md-primary", 
      "ng-model": "#{object_attr}", 
      "ng-init":  "#{c_name}=#{c_klass.all.to_a.to_json};#{object_attr}=#{attr_value || 'null'}"
      }.merge(options)


    @template.content_tag(:"md-select", value, md_seclet_opt) do
      @template.content_tag(:"md-option", value, {"ng-repeat": "#{c_item} in #{c_name}", "ng-value": "#{c_item}.#{c_key}"}) do
        "{{ #{c_item}.#{c_show} }}"
      end
    end + hidden_field(c_fk, {"ng-value": "#{object_attr}"})
  end

  def ng_datetime(attribute)
    object_attr = "#{object_name}.#{attribute}"
# <mdp-date-picker mdp-placeholder="Date" ng-model="currentDate"></mdp-date-picker>
    @template.content_tag(:"md-datepicker", nil, {"ng-model": "#{object_attr}", "ng-init": "#{object_attr}=_gen_date('#{DateTime.now}')"}) + hidden_field(attribute, {"ng-value": "#{object_attr}"})
  end

end