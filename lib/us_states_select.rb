module ActionView
  module Helpers
    module FormOptionsHelper
      def us_state_options_for_select(selected = nil, options = {})
        state_options      = ""
        priority_states    = lambda { |state| options[:priority].include?(state.last) }
        options[:show] = :full if options[:with_abbreviation]
        states_label = case options[:show]
          when :full_abb          then lambda { |state| [state.first, state.last] }
          when :full              then lambda { |state| [state.first, state.first] }
          when :abbreviations     then lambda { |state| [state.last, state.last] }
          when :abb_full_abb      then lambda { |state| ["#{state.last} - #{state.first}", state.last] }
          else                         lambda { |state| state }
        end
        states_label = options[:show] if options[:show].is_a?(Proc)

        if options[:priority]
          state_options += options_for_select(US_STATES.select(&priority_states).collect(&states_label), selected)
          state_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
          
          selected = nil if options[:priority].include?(selected)
        end

        state_options += options_for_select(US_STATES.collect(&states_label), selected)
        return state_options.html_safe if state_options.respond_to?(:html_safe)
        state_options
      end

      def us_state_select(object, method, us_state_options = {}, options = {}, html_options = {})
        options.merge!(us_state_options)
        InstanceTag.new(object, method, self, options.delete(:object)).to_us_state_select_tag(options, html_options)
      end

      private
        US_STATES = [["Alaska", "AK"], ["Alabama", "AL"], ["Arkansas", "AR"], ["Arizona", "AZ"], 
                     ["California", "CA"], ["Colorado", "CO"], ["Connecticut", "CT"], ["District of Columbia", "DC"], 
                     ["Delaware", "DE"], ["Florida", "FL"], ["Georgia", "GA"], ["Hawaii", "HI"], ["Iowa", "IA"], 
                     ["Idaho", "ID"], ["Illinois", "IL"], ["Indiana", "IN"], ["Kansas", "KS"], ["Kentucky", "KY"], 
                     ["Louisiana", "LA"], ["Massachusetts", "MA"], ["Maryland", "MD"], ["Maine", "ME"], ["Michigan", "MI"], 
                     ["Minnesota", "MN"], ["Missouri", "MO"], ["Mississippi", "MS"], ["Montana", "MT"], ["North Carolina", "NC"], 
                     ["North Dakota", "ND"], ["Nebraska", "NE"], ["New Hampshire", "NH"], ["New Jersey", "NJ"], 
                     ["New Mexico", "NM"], ["Nevada", "NV"], ["New York", "NY"], ["Ohio", "OH"], ["Oklahoma", "OK"], 
                     ["Oregon", "OR"], ["Pennsylvania", "PA"], ["Rhode Island", "RI"], ["South Carolina", "SC"], ["South Dakota", "SD"], 
                     ["Tennessee", "TN"], ["Texas", "TX"], ["Utah", "UT"], ["Virginia", "VA"], ["Vermont", "VT"], 
                     ["Washington", "WA"], ["Wisconsin", "WI"], ["West Virginia", "WV"], ["Wyoming", "WY"]] unless const_defined?("US_STATES")

    end

    class InstanceTag #:nodoc:
      def to_us_state_select_tag(options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        content_tag("select", add_options(us_state_options_for_select(value(object), options), options, value(object)), html_options)
      end
    end
    
    class FormBuilder
      def us_state_select(method, us_state_options = {}, options = {}, html_options = {})
        @template.us_state_select(@object_name, method, us_state_options, options.merge(:object => @object), html_options)
      end
    end
  end
end
