include: "jordans_project.model.lkml"
view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: id {field: order_items.id}
      column: total_sales {}
      column: count {}
      derived_column: order_revenue_rank {
        sql: RANK() OVER (ORDER BY total_revenue desc) ;;
      }
    }
  }
  dimension: id {
    primary_key: yes
    type: number
  }
  dimension: total_sales {
    type: number
  }
  dimension: count {
    type: number
  }
}
