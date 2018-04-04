connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: jordans_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

datagroup: order_items {
  sql_trigger:  select max(created_at) from order_items ;;
  max_cache_age: "4 hours"
}
persist_with: jordans_project_default_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: user_advanced {
  extends: [users]
  from:  user_information
  view_name:  users
    join: user_information {
      type: left_outer
      relationship:  one_to_one
      sql_on:  ${user_information.user_id} = ${users.user_id} ;;
    }
  join: user_data {
    type: inner
    relationship: one_to_one
    sql_on:  ${users.user_id} = ${user_data.id} ;;
  }
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: user_orders {}

explore: users {}

explore: order_facts {}

explore: users_nn {}
