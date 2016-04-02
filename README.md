# campminder-elixir

A [CampMinder API](https://webapi.campminder.com/help) integration for use in Elixir.

## Current capabilities

TODO:

- Add New Lead
- Add Custom Data
- Get Telegraph reports
- Run Telegraph report
- Retrieve person ID by email

## Installation

Add `campminder` to your list of dependencies in `mix.exs`:

```
def deps do
  [{:campminder, "~> 0.0.1"}]
end
```

Ensure `campminder` is started before your application:

```
def application do
  [applications: [:campminder]]
end
```

Set the CampMinder ID and token in one of two places:

1. As system environment variables named `CAMPMINDER_CAMP_ID` and `CAMPMINDER_TOKEN`.
2. In your `config/config.exs` file:

```
use Mix.Config

config :campminder, camp_id: :value
config :campminder, token: :value
```

## Planning Qs:

How to set the ID and token globally for the application? Set it up as an application!
