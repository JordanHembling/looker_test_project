
view: user_orders {
  derived_table: {
    sql:
        select
        (@position := ifnull(@position, 0) + 1) AS prim_key,
        u.*, sum(sale_price) as total_price from users u
        join orders o on u.id = o.user_id
        join order_items oi on o.id = oi.order_id
      group by o.user_id
      order by o.user_id;
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: p_key {
    type: number
    primary_key: yes
    sql:  ${TABLE}.prim_key ;;

  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
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
      user_id,
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
