view: tablalooker {
  derived_table: {
    explore_source: order_items {
      column: id { field: inventory_items.id }
      column: rank { field: products.rank }
      column: first_name { field: users.first_name }
    }
  }
  dimension: id {
    type: number
  }
  dimension: rank {
    type: number
  }
  dimension: first_name {}

  measure: suma {
    type: sum
    sql: ${rank} ;;
  }
}
