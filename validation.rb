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
      self.class.validations.each do |validation|
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
      raise "Неверный формат для имени" if attribute !~ format
    end

    def validate_balance(gamer)
      raise "У Вас мало денег" if gamer.entity == :player &&
                                  !gamer.balance_valid?

      raise "У крупье мало денег" if gamer.entity == :croupier &&
                                     !gamer.balance_valid?
    end
  end
end
