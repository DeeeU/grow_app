# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Test Commands

- Start server: `rails server` or `bin/rails server`
- Start with Docker: `docker-compose up -d`
- Run all tests: `bundle exec rspec`
- Run single test: `bundle exec rspec <path_to_spec_file>:<line_number>`
- Run specific test file: `bundle exec rspec spec/path/to/file_spec.rb`
- Run Rails console: `rails console` or `bin/rails console`
- Database migrations: `rails db:migrate`
- Docker console: `docker-compose exec web bin/rails console`
- Code quality check: `bundle exec rails_best_practices .`

## Code Style Guidelines

- Ruby version: 3.3.0, Rails: 7.1.3
- Follow Rails conventions and RESTful design principles
- Use RuboCop for linting (gems: rubocop, rubocop-rails, rubocop-rspec)
- Code quality checks with Rails Best Practices
- Spacing: 2 spaces for indentation
- Models: Use annotations, follow ActiveRecord conventions
- Tests: RSpec with FactoryBot, organize in spec/ directory
- Error handling: Use Rails standard error handling
- Security: Avoid direct SQL queries, use parameterized inputs
- JavaScript: Use Stimulus for front-end interactions
- CSS: Use Tailwind CSS for styling

## CI Requirements

Before submitting code, always run:
1. Tests: `bundle exec rspec`
2. Code quality check: `bundle exec rails_best_practices .`