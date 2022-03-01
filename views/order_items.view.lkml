####estecambop
# The name of this view in Looker is "Order Items"
view: order_items {


  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.order_items ;;
  drill_fields: [id,inventory_item_id,order_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  parameter: parametrofec {
    type: date
    #default_value: "today" esto genera un error lookml, supongo por el tipo de dato
  }


  parameter: anio {
    type: string
    allowed_value: {value:"2001"}
    allowed_value: {value:"2002"}
  }

  dimension: usandoparametrodate {
    label_from_parameter:anio
    sql: CASE
      WHEN cast({%parameter parametrofec %}as date)=${returned_date}
      THEN
      'si'
      ELSE 'otro'
    END;;
  }

# --{%condition parametrofec%}${returned_date}{% endcondition %}

#dimension: comparan {
#sql:  {% if DATE(parametro_echa._parameter_value) == ${returned_date}%}
#'1'
#{% else %}
#'0'
#{% endif %};;
#}


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    suggest_dimension:order_items.stringtype
    html: <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAJUlEQVR42u3NQQEAAAQEsJNcdFLw2gqsMukcK4lEIpFIJBLJS7KG6yVo40DbTgAAAABJRU5ErkJggg==" alt = 'hello' />;;

  }


  dimension: stringtype {
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }


  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

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

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    #  datatype: date
    sql: DATEADD(year,8, ${TABLE}.returned_at) ;;
  }

  dimension: sale_price {
    type: number
    hidden: no
    sql: ${TABLE}.sale_price ;;
    value_format: "$0.00"
  }

  dimension: sale_price_two {
    #type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name:usd
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_sale_price {
    type: sum
    hidden: yes
    sql: ${sale_price} ;;

#can_filter:yes
  }


  measure: average_sale_price {
    type: average
    hidden: yes
    sql: ${sale_price} ;;
  }

  measure:total_revenue {
    type: sum
    hidden: no
    sql: ${sale_price} ;;
    value_format: "$0.00"
  }

#esto esta mal una medida de agregacion no puede referenciar a otra
  #measure: conteofiltrado {
  # type: sum
  #filters: [total_revenue:  ">950"]
  #}
}
