# frozen_string_literal: true

require_relative 'lib/rk_theory/version'

Gem::Specification.new do |spec|
  spec.name          = 'rk_theory'
  spec.version       = RKTheory::VERSION
  spec.authors       = ['João Soares']
  spec.email         = ['jsoaresgera@gmail.com']

  spec.summary       = 'Simple terminal game to implement path finding algorithms'
  spec.description   = <<-DESC
    2D Terminal game where a bunny needs to find a carrot using pathfinding algorithms:
    - Flood finding
    - Dijkstra
    - A* (A-Star)
  DESC
  spec.homepage      = 'http://rqtheory.gintechtonic.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/jasoares/rk_theory'
  spec.metadata['changelog_uri'] = 'https://github.com/jasoares/rk_theory/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = %w[console setup rktheory]
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'curses', '~> 1.2'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.19'
  spec.add_development_dependency 'simplecov', '~> 0.22'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
