# frozen_string_literal: true

require 'chart/version'
require 'chart/store/base'
require 'chart/store/has_one'
require 'chart/store/has_many'
require 'chart/models/base'
require 'chart/models/offer'
require 'chart/models/product'
require 'chart/models/delivery_fee'
require 'chart/models/basket'
require 'chart/initializers/base'
require 'chart/initializers/product'
require 'chart/initializers/delivery_fee'

# Chart module provides functionality for creating and manipulating charts
module Chart
  # Application class provides functionality for running the application
  class App
    def self.run!
      @app = new

      loop do
        command = gets.chomp.strip

        if %w[exit quit q].include?(command)
          puts 'quitting...'
          break
        end

        puts @app.run(
          command.split[0],
          command.split[1],
          command.split[2],
          command.split[3]
        ) || 'Not found'
        puts "\n"
      end
    end

    def initialize
      display_intro
    end

    def run(command, arg, _aarg, _aaarg)
      case command
      when 'init'
        init
      when 'list'
        list(arg)
      when 'add'
      when 'total'
      else
        puts "Unable to find command.\n\n"
        display_help
      end
    end

    def init
      Chart::Initializers::Product.new.execute
      Chart::Initializers::DeliveryFee.new.execute
    end

    def list(resource)
      case resource
      when 'products'
        Chart::Models::Product.all
      when 'delivery_fees'
        Chart::Models::DeliveryFee.all
      when 'offers'
        Chart::Models::Offer.all
      when 'baskets'
        Chart::Models::Basket.all
      when 'all'
        list_all
      else
        'Unable to find resource. Available resources: products, delivery_fees, offers, baskets'
      end
    end

    private

    def assign_default(data, default = 'empty')
      return default if data.empty?

      data
    end

    def list_all
      [
        "\n---------",
        '📚 products:',
        assign_default(Chart::Models::Product.all),
        "\n---------",
        '📦 delivery_fees:',
        assign_default(Chart::Models::DeliveryFee.all),
        "\n---------",
        '💰 offers:',
        assign_default(Chart::Models::Offer.all),
        "\n---------",
        '🛒 baskets:',
        assign_default(Chart::Models::Basket.all),
        "\n"
      ].join("\n")
    end

    def display_intro
      puts <<~INTRO
        🎉 Welcome to the Chart Wizard! 🎉

        Ready to take your shopping experience to the next level?
        With our magical commands, you can easily manage your product catalogue, delivery fees, and offers!

        Here’s what you can do:

        1. 🌟 `init` - Kickstart your adventure by initializing the product catalogue, delivery charge rules, and offers.
        2. 📜 `list <resource>` - Want to see what’s in your treasure chest? List resources like `products`, `baskets`, `delivery_fees`, and `offers`. Use `all` to unveil everything at once!
        3. ➕ `add <product_code> <quantity>` - Add your favorite products to the chart! If you forget to specify a quantity, don’t worry—just one will be added by default.
        4. 💰 `total` - Ready to see how much your shopping spree costs? Calculate the total price of all products in your chart with just a simple command!
        5. 🚪 `quit` - Exit the Chart Wizard.

        Let’s get started! Type `init` to begin your journey. Happy shopping! 🛒✨
      INTRO
    end

    def display_help
      puts <<~HELP
        📚 Help Center 📚

        Need assistance? Here are some handy commands to get you started:

        1. 🌟 `init` - Initialize the product catalogue, delivery charge rules, and offers.
        2. 📜 `list <resource>` - List resources like `products`, `baskets`, `delivery_fees`, and `offers`.
        3. ➕ `add <product_code> <quantity>` - Add products to your chart.
        4. 💰 `total` - Calculate the total price of all products in your chart.
        5. 🚪 `quit` - Exit the Chart Wizard.

        Happy shopping! 🛒✨
      HELP
    end
  end
end
