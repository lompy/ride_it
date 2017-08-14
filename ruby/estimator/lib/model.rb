require 'money'

module Model
  Currency = Money::Currency.new('RUB')
  Money.default_currency = Currency

  def self.format_money(money)
    money.format(symbol: nil, separator: '.', delimiter: '')
  end
end
I18n.enforce_available_locales = false

Dir[File.join(__dir__, '/model/', '*.rb')].each { |f| require f }
