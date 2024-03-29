# Define the database connection to be used for this model.
connection: "salesgcpea"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: gcp_luisjimenez_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: gcp_luisjimenez_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Gcp Luisjimenez"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: customers {}

explore: date {}

explore: markets {}

explore: products {}

explore: transactions {
  label: "Transactions Luis"

  sql_always_where: ${transactions.sales_amount}>0 AND
                    ${transactions.currency} != "USD\r" AND
                    ${transactions.currency} != "INR" AND
                    ${transactions.order_year} >2017;;
  join: customers {
    foreign_key: customer_code
    relationship: many_to_one
  }

  join: markets {
    foreign_key: market_code
    relationship: many_to_one
  }

  join: products {
    foreign_key: product_code
    relationship: many_to_one
  }
}
