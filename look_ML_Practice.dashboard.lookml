- dashboard: look_ml_practice
  title: Look Ml Practice
  layout: tile
  tile_size: 100

  filters:

  - name: state
    title: "State"
    type: field_filter
    explore: users
    field: users.state

  - name: city
    title: "City"
    type: field_filter
    explore: users
    field: users.city
    listens_to_filters: [state]

  - name: age
    title: "Age"
    type: number
    explore: users
    field: users.age
    listens_to_filters: [state, city]


  elements:
    - name: hello_world
      type: looker_column
      model: jordans_project
      explore: order_items
      type: looker_column
      fields: [order_items.total_sales, orders.created_month, products.brand]
      pivots: [products.brand]
      fill_fields: [orders.created_month]

      sorts: [orders.created_month desc, products.brand]
      limit: 500
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: editable
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      series_types: {}
