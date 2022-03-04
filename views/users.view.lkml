# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.users ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  parameter: filtrodefecha {
    type: date
  }



  dimension: id {
    primary_key: yes
    type: number
    sql:${TABLE}.id ;;
  group_label: "estegrupo,otrogrupo"

  }


  dimension: dateweek {
    type: date_week
    sql: ${TABLE}.created_at ;;

  }


  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Age" in Explore.

  dimension: sino {
    type: yesno
    sql: ${first_name} like '%Ade'  ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    drill_fields: [country]
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    case_sensitive: yes
    sql: ${TABLE}.first_name ;;
  }



  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gender_copy {
    type: string
    sql: ${TABLE}.gender ;;
  }




  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: sinodim {
    type: yesno
    sql: ${TABLE}.gender like 'f' ;;
  }

  dimension: sinodoble {
    type: yesno
    sql: Case when  ${sinodim}='no' and ${gender}='m' then 1 else 0 end;;
  }



  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: full_name {
    hidden: no
    sql: ${first_name}||' '||${last_name} ;;

  }

  dimension: full_name_two {
    hidden: no
    sql: concat(concat(${first_name},' '),${last_name}) ;;

  }
  dimension: lenght {
    hidden: no
    type: number
    sql: length(${full_name}) ;;
    label: "longitud del nombre"
    description: "longitud por caracter del nombre"
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100,110]
    style: interval
    sql: ${age} ;;
    value_format: "0"

  }


  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.counts]
  }


  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_age {
    type: sum
    hidden: no
    sql: ${age} ;;
  }



  measure: www {
    sql: (${age}*100)/${total_age} ;;
  }

  measure: average_age {
    type: average
    hidden: no
    sql:${TABLE}.age ;;
  }

  measure: sexofiltrado {
    type: count
    filters: [gender: "f"]
  }



  dimension: sumamala {
    type:number
    sql: ${age}+${age} ;;


  }

}
