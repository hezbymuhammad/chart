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
require 'chart/initializers/offer'

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
        ) || "\n👩‍⚕️ enter ? to show navigation options. Enter q to quit"
        puts "\n"
      end
    end

    attr_accessor :is_init

    def initialize
      display_intro
      @is_init = false
    end

    def run(command, arg, aarg, _aaarg)
      case command
      when 'init'
        init
        @is_init = true
      when 'list'
        check_is_init && list(arg)
      when 'add'
        check_is_init && add(arg, aarg)
      when 'total'
        check_is_init && total
      when 'checkout'
        check_is_init && checkout
      when 'help'
        display_help
      when '?'
        display_help
      else
        puts "❌ Unable to find command.\n\n"
        display_help
      end
    end

    def init
      puts "🚀 Initializing your application... Please hold on tight! 🌟"

      puts "🛠️  Setting up your product data..."
      Chart::Initializers::Product.new.execute
      puts "✅ Products initialized successfully!"

      puts "🛠️  Setting up your delivery fee rules..."
      Chart::Initializers::DeliveryFee.new.execute
      puts "✅ Delivery fees initialized successfully!"

      puts "🛠️  Setting up your offers..."
      Chart::Initializers::Offer.new.execute
      puts "✅ Offers initialized successfully!"

      puts "🎉 All initializers have been run successfully! Your application is ready to go! 🎉"
      puts "Happy shopping! 🛒✨"
    end

    def list(resource)
      case resource
      when 'products'
        [
          "📚 products:",
          Chart::Models::Product.all
        ].join("\n")
      when 'delivery_fees'
        [
          "📦 delivery_fees:",
          Chart::Models::DeliveryFee.all
        ].join("\n")
      when 'offers'
        [
          "💰 offers:",
          Chart::Models::Offer.all
        ].join("\n")
      when 'baskets'
        [
          "🛒 baskets:",
          Chart::Models::Basket.all
        ].join("\n")
      when 'all'
        list_all
      else
        "Unable to find resource.\n Available resources: 📚 products, 📦 delivery_fees, 💰 offers, 🛒 baskets"
      end
    end

    def add(product_code, quantity = 1)
      cleaned_quantity =  quantity.nil? ? 1 : quantity.to_f

      begin
        Chart::Models::Basket.add(product_code, cleaned_quantity)
      rescue StandardError => e
        puts "\n‼️‼️‼️ Error adding product to basket: #{e.message}"
      end
    end

    def total
      Chart::Models::Basket.calculate_total_price
    end

    def checkout
      Chart::Models::Basket.checkout

      <<~MESSAGE
        🎉 Checkout Complete! 🎉

        Your chart has been successfully checked out. 🛒✨
        It's now EMPTY and ready for your next shopping adventure!

        Happy shopping! 🛍️
      MESSAGE
    end

    private

    def check_is_init
      if @is_init == false
        puts "\n‼️‼️‼️ Please initialize using init before using this command."

        return false
      end

      true
    end

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
        5. ✅ `checkout` - Yay. You are successfully checked out the card, now its empty! Reset your chart with just a simple command!
        6. 🚪 `quit` - Exit the Chart Wizard.

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
        5. ✅ `checkout` - Yay. You are successfully checked out the card, now its empty! Reset your chart with just a simple command!
        6. 🚪 `quit` - Exit the Chart Wizard.

        Happy shopping! 🛒✨
      HELP
    end
  end
end
