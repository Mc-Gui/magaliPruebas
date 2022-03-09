######
# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.orders ;;
  drill_fields:[source*, id]


  filter: filtrodefecha3 {
    type: date
  }

  dimension: esfecha {
    sql: {% date_start filtrodefecha3 %} ;;
  }

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;



  }

  dimension: dependedeotravista {
    type: string
    sql:  ${TABLE}.id ;;
    #html:{% if products.brand3._value== 'Calvin Klein' %}
     #   <p style="text-align:left; margin-left:1px; line-height:0.2; font-size:14px; color:blue; white-space:pre-wrap">{{ rendered_value }}</p>
#{% endif %};;

html:<div> <a href="https://docs.looker.com/exploring-data/exploring-data/merged-results"
<p style = "text-align:left; margin-left:1px; line-height:0.2; font-size:20px; color:black;">
<p style = "text-align:left; margin-left:1px; line-height:0.2; font-size:14px; color:blue; white-space:pre-wrap;"> &#10551 GO TO: &nbsp; {{rendered_value}} </a>
<br> </div>;;


  }

  dimension: dependedeotravistados {
    type: string
    sql:  ${TABLE}.id ;;
    #html:{% if products.brand3._value== 'Calvin Klein' %}
    #   <p style="text-align:left; margin-left:1px; line-height:0.2; font-size:14px; color:blue; white-space:pre-wrap">{{ rendered_value }}</p>
#{% endif %};;

    html:<div>  <a href="https://docs.looker.com/exploring-data/exploring-data/merged-results"
      <p style = "text-align:left; margin-left:1px; line-height:0.2; font-size:20px; color:black;">
      <p style = "text-align:left; margin-left:1px; line-height:0.2; font-size:14px; color:blue; white-space:pre-wrap;">&#10551 GO TO: &nbsp; {{rendered_value}} </a></div>;;


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
      year,day_of_week
    ]
    sql: ${TABLE}.created_at ;;


    #no jala para todos los tipos y puede generar error, mejor crear otra dimension con puro date
  #  html:

   #     {% if _user_attributes['magali'] %}

    #  {{ value | date: "%A, %B %e, %Y " }}

    #{% else %}

     # {{ rendered_value | date: "%b %d, %y" }}

    #{% endif %};;

  }

  measure:maximafecha
  {
    type: date
    sql: MAX(${created_date}) ;;
    convert_tz: no

  }

  measure: diffecha
  {
    type: number
    sql: datediff(day,${maximafecha},GETDATE()) ;;
  }


  #crea un picker
  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    default_value: "Date"
    allowed_value: { value: "Date" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Year" }
  }

  dimension: fechadinamic {
    label_from_parameter: timeframe_picker
    type:date
    sql:
        CASE--estos casteos son para poder hacer cumplir con el tipo de dato de la dimension
          WHEN {% parameter timeframe_picker %} = 'Date' THEN ${created_date}
          WHEN {% parameter timeframe_picker %} = 'Month' THEN TO_DATE(${created_month},'YYYY-MM')--esto no se puede por que el tipo es date y este formato es una cadena
          WHEN {% parameter timeframe_picker %} = 'Quarter' THEN TO_DATE(${created_quarter},'YYYY-MM')
          WHEN {% parameter timeframe_picker %} = 'Year' THEN TO_DATE(${created_year},'YYYY')
          ELSE NULL
        END ;;#tambien se puede hacer esto con if

      html:


        {% if parameter.timeframe_picker._value == "'Date'" %}

        {{ value | date: "%A, %B %e, %Y " }}

        {% elsif parameter.timeframe_picker._value == "'Month'" %}

       {{ rendered_value | date: " %B %Y" }}

        {% else %}

        {{rendered_value}}

        {% endif %}

        ;;





      }

# My customized timeframes, added under the group "Created"
      dimension: date_formatted {
        #group_label: "Created" label: "Date"
        sql: ${created_date} ;;
        html: {{ rendered_value | date: "%A, %B %e, %Y" }};;
      }

      dimension: week_formatted {
        #group_label: "Created" label: "Week"
        sql: ${created_week} ;;
        html: {{ rendered_value | date: "Week %U (%b %d)" }};;
      }

      dimension: month_formatted {
        #group_label: "Created" label: "Month"
        sql: ${created_month} ;;
        html: {{ rendered_value | append: "-01" | date: "%B %Y" }};;
      }







      #crea un picker
      parameter: dimension_picker {
        type: string
        allowed_value: { value: "statusss" }
        allowed_value: { value: "traffic_source" }
        allowed_value: { value: "productsbrand" }
        default_value: "statusss"
      }

      dimension: dimensiondinamica {
        label_from_parameter: dimension_picker
        sql:
        CASE
          WHEN {% parameter dimension_picker %} = 'statusss' THEN ${statusss}
          WHEN {% parameter dimension_picker %} = 'traffic_source' THEN ${traffic_source}
          WHEN {% parameter dimension_picker %} = 'productsbrand' THEN ${products.brand}

          ELSE NULL
        END ;;

        drill_fields: [source*]


        }




        parameter: parafiltrarestatus {
          type:string
          allowed_value: {value:"Complete"}
        }

        dimension: statusss {
          type: string
          sql: ${TABLE}.status ;;
         # drill_fields: [id, users.id, users.first_name]
          suggest_explore: vistamanual
          suggest_dimension: vistamanual.parasugerencia
        }

        dimension: traffic_source {
          type: string
          sql: ${TABLE}.traffic_source ;;
        }

        dimension: user_id {
          type: number
          # hidden: yes
          sql: ${TABLE}.user_id ;;
          label: "{{ _filters['statusss'] }}"


        }


        # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
        # measures for numeric dimensions, but you can also add measures of many different types.
        # Click on the type parameter to see all the options in the Quick Help panel on the right.

        measure: count {
          type: count
          drill_fields: [source*]
          }

        measure: cancelled_orders_last_week {
          type: count
          filters: [statusss: "cancelled"]
        }





        set: source {

          fields: [traffic_source, created_date,products.brand,esfecha,id,created_month, products.ids, product_facts.image_file ]

        }
        #comit

      }
