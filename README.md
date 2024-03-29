# Klepsidra

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## To do

- Create Notes entity, and make it possible to record notes from timers
- Enable SQLite full-text search
- Create customised scripts for pre-commint hooks, with better action messages
- Start enabling full-text search on relevant database fields
- Make form dynamic: changing start or end times must recalculate durations
- Rename 'reporting duration' and 'reporting duration time unit' fields to 'invoicing'?
- Add checkbox determining whether time is billable?
- Resize datetime, duration and duration unit controls to more efficiently use space
- Change tag to a many-to-many relationship
- Update tag picking for multiple tag selection
- Start implementing colour palette
- Reformat listing display to a more useful format, removing description field to a popup box or tooltip; change date display to more informative format
- Change data defaults for duration to nil, and no duration time units until clocking out

### Tests

- Test on month-first locales
- Test on 12-hour clock locales
- Do all browsers return a 'T' delimited datetime-local stamp? Do both delimiters need to be handled? According to the standard, yes

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
