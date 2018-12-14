# frozen_string_literal: true

module BaseValues
  WELCOME_SCREEN = "Welcome, wanna make some money?"
  MAX_CARDS = 3
  BLACK_JACK = 21
  BET = 10
  START_MONEY = 20
  VALUE_TO_REACH = 17
  MASK = "######"
  NAME_FORMAT = /^\w{4,}/.freeze
  DELIMITER = "------------------------------------------"
  ROUND_MENU = ["1 - Новая игра , 2 или прочий символ выход - выход"].freeze
  PLAYER_MENU = ["1 - Взять карту",
                 "2 - пропустить ход",
                 "3 - открыть карты",
                 "4 - остановить игру"].freeze
end
