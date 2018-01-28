# Database

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


# Creating a website for the assignment given from the Genome Institute

First of all I made up a simple plan of implementing the site:

1. Create the Elixir project.
2. Create the necesarry database table with the fields: code, idcode, isnt, time, first, last, email.
3. Research how to create an upload form page for csv and how to put the csv data into the DB.
4. Create the upload form page
5. Research how to display the data and how to implement a search into it.
6. Create the page that displays the data which has a search function.

First of all I started by searching how to implement an upload form in Elixir, this is the most difficult part so this will take some time.

Tried using "csv" dependency but it did not work, "CSVLixir" dependency worked quite well!

Trying to use "Rummage" dependency, not really working. Eventually I got it to work, a typical problem with open-source dependecies that are often updated :). 

Sorting and pagination works, but I have issues with the search form.



<!-->
<%= search_form(@conn, @rummage, 
  [fields:
    [code: %{label: "Search by ID", search_type: "ilike"}],
  ], button_class: "btn",
  )

%> -->