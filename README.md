# Simple Chart Solution

Simple chart solution

# Requirements

Ruby 3.4.2

# Installation

```bash
./bin/build
```

# Usage

```bash
./bin/chart
<command>
```

These are the list of commands:

1. `init` - Initialize product catalogue, delivery charge rules, and offers.
2. `list <resource>` - List resources: `products`, `delivery_fees`, and `offers`. Use `all` to display all resources.
3. `add <product_code> <quantity>` - Add product to the chart. If you don't enter quantity, it will be assumed as 1.
4. `total` - Calculate total price of products in the chart.
