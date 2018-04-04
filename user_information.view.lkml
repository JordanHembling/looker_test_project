view: user_information {
  derived_table: {
    indexes: ["id"]
    datagroup_trigger: order_items


    sql: select u.id as user_id, concat(u.first_name, " ",u.last_name) as full_name, email, gender, state, zip, count(o.id) as order_count, sum(oi.sale_price) as total_revenue, min(o.created_at) as First_order_date, max(o.created_at) as Last_order_date from users u
        join orders o on u.id = o.user_id
        join order_items oi on o.id = oi.order_id
      group by u.id
       ;;

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.First_order_date ;;
  }

  dimension_group: last_order_date {
    type: time
    sql: ${TABLE}.Last_order_date ;;
  }

  set: detail {
    fields: [
      user_id,
      full_name,
      email,
      gender,
      state,
      zip,
      order_count,
      total_revenue,
      first_order_date_time,
      last_order_date_time
    ]
  }
}
