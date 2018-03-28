
view: user_orders {
  derived_table: {
    sql: select
        row_number() OVER(order by o.id) as primary_key,
        2 as number2,
        u.*, sum(sale_price) as total_price from users u
        join orders o on u.id = o.user_id
        join order_items oi on o.id = oi.order_id
      group by o.id
      order by email;
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
  }

  set: detail {
    fields: [
      id,
      email,
      first_name,
      last_name,
      gender,
      created_at_time,
      zip,
      country,
      state,
      city,
      age,
      total_price
    ]
  }
}
