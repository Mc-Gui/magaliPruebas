- dashboard: system
  title: systemactivitydashboardssss
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: systemactivitydas
    name: systemactivitydas
    model: system__activity
    explore: history
    type: table
    fields: [history.id, user.email]
    limit: 500
    query_timezone: UTC
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: system__activity
    explore: pdt_event_log
    type: looker_grid
    fields: [pdt_builds.connection, pdt_event_log.action, pdt_event_log.connection,
      pdt_event_log.hash, pdt_event_log.model_name, pdt_builds.status, pdt_builds.context,
      pdt_builds.dev_build, pdt_builds.view_name, pdt_builds.workspace, pdt_event_log.extract_view_from_table,
      pdt_event_log.id, pdt_event_log.incremental_build, pdt_event_log.tid, pdt_event_log.sequence]
    sorts: [pdt_builds.connection]
    limit: 500
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '14'
    rows_font_size: '14'
    header_font_color: "#eff4f6"
    header_background_color: "#1b2327"
    show_sql_query_menu_options: false
    conditional_formatting_include_nulls: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"

    series_text_format:
     pdt_builds.connection:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.action:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.connection:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.hash:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.model_name:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_builds.status:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_builds.context:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_builds.dev_build:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_builds.view_name:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_builds.workspace:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.extract_view_from_table:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.id:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.incremental_build:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.tid:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

     pdt_event_log.sequence:
      bg_color: "#1b2327"
      fg_color: "#eff4f6"

    defaults_version: 1
    series_types: {}
    row: 14
    col: 0
    width: 24
    height: 21
