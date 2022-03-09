view: sql_derivadauno {
  derived_table: {
    sql: SELECT
          "users"."email" AS "users.email",
          "users"."id" AS "users.id",
          "orders"."id" AS "orders.id"
      FROM
          "public"."order_items" AS "order_items"
          LEFT JOIN "public"."orders" AS "orders" ON "order_items"."order_id" = "orders"."id"
          LEFT JOIN "public"."users" AS "users" ON "orders"."user_id" = "users"."id"
      GROUP BY
          1,
          2,
          3
      ORDER BY
          2

      OFFSET {{ number_per_page._parameter_value | times: page._parameter_value | minus: number_per_page._parameter_value }}


       ;;
  }

  parameter: page {
    type: number
  }


  parameter: number_per_page {

    type: number
    default_value: "5000"
    hidden: yes

  }

dimension: parameter_value{
  sql:{{ number_per_page._parameter_value | times: page._parameter_value | minus: number_per_page._parameter_value }}  ;;
}


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_email {
    type: string
    sql: ${TABLE}."users.email" ;;
  }

  dimension: calculo {
    sql: 5000*13 ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}."users.id" ;;
  }

  dimension: orders_id{
    type: number
    sql: ${TABLE}."orders.id" ;;
  }

  set: detail {
    fields: [users_email, orders_id]
  }
}