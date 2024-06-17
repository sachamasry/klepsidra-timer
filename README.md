# Klepsidra

Time your activities to bill clients, and understand where your time goes.

## Overview

Klepsidra is an activity timer for freelance service providers, agencies, developers, and others
providing services quoted and billed in time taken. Use it to time activities, for internal
use and analysis, and for client billings.

## Setup & Installation

Install Elixir, clone this repository, then change into its directory.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## To do

- Decide on critical functionality needed for MVP, or first release; document requirements

### MVP: Make application self-hosting

- Validate start and end stamp user input
- Fix 'reported duration' units
  - Change name to billing time increment
  - Ensure 'regular' timer form drop-down has all timer increments available
  - Ensure that duration and billing duration fields are calculated from their time unit choice
  - Changing either the start or end stamp must recalcualate both durations
  - Refactor code to reduce duplication
- Complete all data structure, validations, defaults and indexes needed
  - Create a many-to-many projects to tags table
  - Create a business partners `notes` table
  - Create a projects `notes` table
- Tagging UX improvements
  - Make it possible to drill into the tag from the live component
  - Remove old tagging attempts from views
- Provide a 'today' view
  - Timers recorded today
  - Open timers needing closing
- Provide reporting
  - Filter: by customer; tags; date range

### Future

- Tagging UX improvements
  - Provide ability to set new tag colour when creating freeform tag in live component
  - Document tag selector live component
  - Improve search functionality to perform fuzzy query directly in the database
  - Develop ability to cope with temporary data structures, before a timer has been created?
- Look into default `timestamps()` fields; it appears that datetime stamps are in UTC, where local timezone may be preferable
  - Specifically for timestamps recorded for notes
- Full-text search
  - Create a full-text tag search
  - Begin adding keyboard shortcuts for an improved user interface
  - Enable SQLite notes field full-text search
  - Start enabling full-text search on other relevant database fields
- Make form dynamic: changing start or end times must recalculate durations
- Rename 'reporting duration' and 'reporting duration time unit' fields to 'invoicing'?
- Resize datetime, duration and duration unit controls to more efficiently use space
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
