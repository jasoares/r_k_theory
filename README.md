# RKTheory

## Because images are worth a thousand words

![Path Finding](https://github.com/jasoares/rk_theory/blob/master/imgs/path_finding.gif?raw=true)

## Work in progress

This project is a work in progress to implement and experiment with path finding algorithms aiming at simulating RK Selection Theory, with a rabbit using different path finding algorithms to find a carrot as efficiently as possible.

Quick summary of current project components:
- `Engine` is the simulation engine that runs the loop for both logic and rendering
- `Terminal` encapsulates most of the bindings with curses
- `Map` loads a simulation like a game loads a map/level
- Each `Tile` can be walkable and has a specific `Position`
- `Bunny` represents the player and uses the different `PathFinding` algorithms
- Multiple algorithms can be implemented subclassing `PathFinding`

## Usage

It runs on the terminal and renders the simulation using curses, to see it in action run
```shell
bin/rk_theory.sh
```

To experiment with the code initiate a console with the project loaded using
```shell
bin/console
```

## Installation

This project is structured as a gem even though **it was never meant to be installed as one**, feel free to try it for yourself
```shell
gem install rk_theory
```

Or add it to your application's Gemfile:
```ruby
gem 'rk_theory'
```
And then execute:
```shell
$ bundle install
```

## Development

After checking out the repo, run `bundle install` to install dependencies and then `bin/rk_theory.sh` to see it in action.

You can run the tests with `rspec` and code linting/best practices with `rubocop`

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jasoares/rk_theory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/jasoares/rk_theory/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RKTheory project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jasoares/rk_theory/blob/master/CODE_OF_CONDUCT.md).
