view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: total_sales {
    type:  sum
    sql:  ${sale_price} ;;
  }

  measure: total_cost {
    type:  sum
    sql: ${inventory_items.cost} ;;
    }

  measure: profit_margin {
    type: number
    sql: (${total_sales}-${total_cost})/(${total_sales} ;;
  }

  measure: average_sale_price {
    type:  average
    sql:  ${sale_price} ;;
  }

  measure: count_not_cancelled {
    type: count
    filters: {
      field: returned_date
      value: "NULL"
    }
  }

  parameter: select_measure_type_parameter {
    label: "Select A Measure"
    type: string
    default_value: "Total Revenue"
    allowed_value: {
      label: "Total Revenue"
      value: "Total Revenue"
    }
    allowed_value: {
      label: "Order Count"
      value: "Order Count"
    }
    allowed_value: {
      label: "Average Sale Price"
      value: "Average Sale Price"
    }
  }

  measure: dynamic_measure {
    label_from_parameter: select_measure_type_parameter
    type: number
    sql: case
          when {% parameter select_measure_type_parameter %} = 'Total Revenue' then
               ${total_sales}
          when {% parameter select_measure_type_parameter %} = 'Order Count' then
               ${count}
          when {% parameter select_measure_type_parameter %} = 'Average Sale Price' then
               ${average_sale_price}
              end
          ;;
    value_format_name: decimal_0
  }



}
