# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation_type, option = nil)
      @validations ||= []
      @validations << { attr: name, type: validation_type, option: option }
    end
  end

  module InstanceMethods
    def validate!
      itself.class.validations.each do |validation|
        validation_method = "validate_#{validation[:type]}".to_sym
        attribute = instance_variable_get("@#{validation[:attr]}")
        option = validation[:option]
        send(validation_method, attribute, option)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(attribute, _option)
      raise "Name can't be empty" if attribute.nil? || attribute.to_s.empty?
    end

    def validate_format(attribute, format)
      raise "Неверный формат значения" if attribute !~ format
    end
  end
end
