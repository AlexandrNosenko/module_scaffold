require_relative './concerns/generatable'
require_relative './concerns/spec_generatable'

module ModuleScaffold
  module Generators
    class PolicySpecGeneratorHelper

      include Generatable
      include SpecGeneratable

      def template_path
        'specs/policy.erb'
      end

      def class_name
        "#{module_name}#{helper_type}"
      end

      def full_class_name
        "#{module_full_name}#{helper_type}"
      end

      def class_file_name
        "#{resource_name}_#{helper_type.underscore}_spec.rb"
      end

      def namespace_dirs
        namespace_modules(module_full_name)[0..-2]
      end

      def permitted_attributes
        model_class.new.attributes.keys
      end

      def permitted_actions
        @controller_helper = ControllerGeneratorHelper.new(module_full_name, options)
        @controller_helper.actions
      end

      def permitted_attributes_formatted_str
        permitted_attributes.map do |attr|
          ":#{attr}"
        end.join(",\n")
      end

      private

      def helper_type
        'Policy'
      end

    end
  end
end