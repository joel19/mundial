# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project status

This is a freshly generated Rails 8.1 application (app module: `Mundial`) with no business logic yet — no models, controllers, or routes beyond the Rails defaults. Structure and conventions below reflect the generated skeleton and this app's specific configuration choices.

## Commands

Setup:
```
bin/setup            # install deps, prepare db, ready to run
```

Run the app:
```
bin/dev               # dev server (via Procfile.dev, if present) — check bin/dev
bin/rails server      # plain Rails server
```

Tests (Minitest, not RSpec):
```
bin/rails test                              # full suite (models, controllers, integration, mailers, helpers)
bin/rails test:system                       # system tests (Capybara + Selenium)
bin/rails test test/models/foo_test.rb      # single file
bin/rails test test/models/foo_test.rb:12   # single test at line
```

Lint / static analysis (all wired into CI — see `.github/workflows/ci.yml`):
```
bin/rubocop              # style (rubocop-rails-omakase base config in .rubocop.yml)
bin/rubocop -A           # autocorrect
bin/brakeman --no-pager  # security static analysis
bin/bundler-audit        # gem vulnerability scan
bin/importmap audit      # JS dependency vulnerability scan
```

Database:
```
bin/rails db:prepare       # create + migrate as needed
bin/rails db:migrate
bin/rails db:test:prepare  # sync test db before running tests (done automatically in CI)
```

## Architecture

- **Rails 8.1**, SQLite via the `sqlite3` gem, Propshaft asset pipeline, importmap-rails for JS (no Node/bundler build step), Hotwire (Turbo + Stimulus) for interactivity.
- **Multiple SQLite databases per environment**, configured in `config/database.yml`: `primary` (app data), `cache`, `queue`, `cable` — each with its own schema file (`db/cache_schema.rb`, `db/queue_schema.rb`, `db/cable_schema.rb`) and, in production, its own `migrations_paths` (`db/cache_migrate`, `db/queue_migrate`, `db/cable_migrate`). Migrations for these subsystems must go in the matching directory, not `db/migrate`.
- Backed by **Solid Cache**, **Solid Queue**, and **Solid Cable** (the `solid_*` gems) — Rails 8's default database-backed adapters for caching, background jobs, and Action Cable, replacing Redis. `config/recurring.yml` configures Solid Queue's recurring/scheduled jobs.
- **Deployment** via Kamal (`config/deploy.yml`, `.kamal/`) to a Docker container (see `Dockerfile`); Thruster handles HTTP asset caching/compression and X-Sendfile in front of Puma.
- Standard Rails dirs apply: `app/models`, `app/controllers`, `app/jobs`, `app/mailers`, `app/views`; `app/javascript/controllers` holds Stimulus controllers, registered in `app/javascript/controllers/index.js`.
- Ruby version pinned in `.ruby-version` (3.4.4).
