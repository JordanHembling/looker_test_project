include: "jordans_project.model.lkml"
view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: id {field: order_items.id}
      column: total_sales {}
      column: count {}
      derived_column: order_revenue_rank {
        sql: set @curRank := 0
            @curRank := @curRank + 1
            order by total_sales desc;;
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
