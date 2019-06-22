# Enumerable Methods

This project involves creating my own implementation of the `Enumerable` module methods from the Ruby core library. The following methods are implemented:

- `my_each`: Yields successive members of the collection.
- `my_each_with_index`: Yields successive members along with their index position.
- `my_select`: Returns a subset of elements which are _truthy_ **or** return `true` when yielded into the block, passed to the function.
- `my_all?`: Returns `true` if all elements are _truthy_ **or** all return `true` when yielded into the block, passed to the function.
- `my_any?`: Returns `true` if any elements are _truthy_ **or** any return `true` when yielded into the block, passed to the function.
- `my_none?`: Returns `true` if none of the elements are _truthy_ **or** none return `true` when yielded into the block, passed to the function.
- `my_count`: Returns the number of elements that returned `true` when yielded into the block, passed to the function, **or** the size of the collection if no block was passed
- `my_map`: Returns a new collection, whose elements are the result of the original elements when yielded to the block, passed to the function.
- `my_inject`: Returns a single value, which is the accumulated result of operations performed between members of the collection, as defined by the block passed to the function.
- Modify `my_map` so that it can also accept a proc.

The new methods are added onto the existing Enumerable module.

## Installation

1. Start the interactive ruby console, using the command `irb`
2. Load the modified enumerable module, `load './enumerable.rb'`
3. Create an array, and use the above custom methods.

## Run tests

From the project root directory run `rspec` or `rspec --format doc`
