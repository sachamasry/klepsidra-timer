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

### MVP: Make application self-hosting

- Debugging
  - Flash message stays on home screen, does not disappear
- UI improvements
  - Correct all entity view titles
  - Correct all entity button labels
  - Update tag list sorting to case-insensitive alphabetical
  - Implement list sorting on entities: projects, business partners, activity types, etc.
  - On stopping an automated timer, there is no need to see start and end times
- Provide a 'today' view
  - Update timer listings
    - Add customer
    - Add timer tags
  - Widen app width from `max-w-2xl` to full width
- Provide reporting
  - Filter: by customer; tags; date range

### Future

- Expand role of activity types beyond the hour rate, to act as a rigid categorisation for major types of activities, which cannot be entrusted to tags only, e.g. exercise, learning, professional development
  - Automate `billable`, duration unit measurements, and tags within it; selecting this on an activity should automatically adjust these attributes on a timer
- Security improvements
  - Improve handling of `return_to` functionality
    - Ensure it is a validated route at point of sending
    - Ensure the parameter is read at the `router.ex` level
    - Send the information through to the target in an `on_mount` function
    - Remove the parameter and clean up the URL, redirecting to it, before the user can see it, in case they want to bookmark the page (https://elixirforum.com/t/how-to-store-return-to-url-when-navigating-from-liveview-to-another-page-liveview-regular/55480/4)
    - Insert it in the render code, as a verified route
- UI improvements
  - Select a UI component framework, to aid in the building of a modern web app
  - Improve on cryptic or incomplete UI error messages
  - Resize datetime, duration and duration unit controls to more efficiently use space
  - Start implementing colour palette
  - Improve presentation of currency fields; at present they use an input control of type 'number' which is unintuitive UX
- Tagging UX improvements
  - Make it possible to drill into the tag from the live component
  - Provide ability to set new tag colour when creating freeform tag in live component
  - Document tag selector live component
  - Improve search functionality to perform fuzzy query directly in the database
  - Develop ability to cope with temporary data structures, before a timer has been created?
- General UX inmprovements
  - Permit pausing and resuming timers; add forward-pointing field to next timer, like a linked list
- Look into default `timestamps()` fields; it appears that datetime stamps are in UTC, where local timezone may be preferable
  - Specifically for timestamps recorded for notes
- Full-text search
  - Create a full-text tag search
  - Begin adding keyboard shortcuts for an improved user interface
  - Enable SQLite notes field full-text search
  - Start enabling full-text search on other relevant database fields
- Reformat listing display to a more useful format, removing description field to a popup box or tooltip; change date display to more informative format
- Change data defaults for duration to nil, and no duration time units until clocking out

### One day

- Break down and list all ultimate desiderata for an activity timer

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
