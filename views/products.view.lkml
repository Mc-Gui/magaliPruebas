view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.products ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.


#esto aplica un filtro en un otro campo, aparece en el where
  filter: esteesunfiltro {
    type: number
    sql: {% if orders.id._is_selected or users.id._is_selected%}
               {%condition esteesunfiltro%}${products.id}{% endcondition %}
          {%endif%} ;;
  }

  parameter: parafiltrarconparametro{
    type: string
    default_value: "Women"
    allowed_value: {label:"Mujer" value:"Women" }
    allowed_value: {label:"hombre" value:"Men"}
  }



  #----------------------------------------DIMENSION----------------------------

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }


  dimension: brand {
    type: string
    #drill_fields: [brand,category]
    sql: ${TABLE}.brand ;;
    ## suggest_dimension: brand2  para que las saugerencias vengan de otra dimension

    #link: {
    # url:"https:// {{value}}"
    #label: "ñññ "
    #url: "https://revistaquem.globo.com/QUEM-News/noticia/2021/08/namorada-da-thiago-oliveira-comenta-brincadeira-de-ana-maria-braga-estou-vendo.html"
    #url: "http://www.google.com/search?q={{ value }}"#es para llevar a una pagina

    # drill to a dashboard
    # url:"https://dcltraining.dev.looker.com/dashboards/743?Gender={{ users.gender._value }}"

    #drill to a explorer
    #url: "https://dcltraining.dev.looker.com/explore/proyecto_copia/order_items?fields=orders.count,products.brand&f[products.brand]={{value}}"

    #Adding Custom Limits (up to 5000)
    #url: "{{link}}&limit=3"


  }

  #usando html

  #drill to a dashboard
  #html:  <a "https://dcltraining.dev.looker.com/dashboards/526?Sold%20Date=2021%2F12%2F02%20to%202021%2F12%2F03&Cost=%5B0,100%5D&Brand3={{value}}">{{ value }}</a> ;;
  # html:<a href:{{linked_value}}></a>  ;;
  # html: <a href="#drillmenu" target="_self">
  # {% if value > 100 %}
  # <font color="darkgreen">{{ rendered_value }}</font>
  #{% elsif value > 50 %}
  #<font color="goldenrod">{{ rendered_value }}</font>
  #{% else %}
  # <font color="darkred">{{ rendered_value }}</font>
  #{% endif %}
  #</a>;;
  #}

  dimension: brand3 {
    sql: ${TABLE}.brand ;;
    html:
          {% if value == 'Calvin Klein' %}
              <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% endif %};;
  }


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "{{ _filters['products.department'] }}"#etiqueta que depende de un filtro
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  measure: rank_clon {
    type: sum
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count, product_facts.count]
    link: {
      # url:"https:// {{value}}"
      label: "drilling "
      #url: "https://revistaquem.globo.com/QUEM-News/noticia/2021/08/namorada-da-thiago-oliveira-comenta-brincadeira-de-ana-maria-braga-estou-vendo.html"
      #url: "http://www.google.com/search?q={{ value }}"#es para llevar a una pagina

      # drill to a dashboard
      url:"https://dcltraining.dev.looker.com/dashboards/743?Gender={{ users.gender._value }}"

      #drill to a explorer
      #url: "https://dcltraining.dev.looker.com/explore/proyecto_copia/order_items?fields=orders.count,products.brand&f[products.brand]={{value}}"

      #Adding Custom Limits (up to 5000)
      #url: "{{link}}&limit=3"


    }

  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_rank {
    type: sum
    hidden: yes
    sql: ${rank} ;;
  }

  measure: average_rank {
    type: average
    hidden: yes
    sql: ${rank} ;;
  }

  measure: total_retail_price {
    type: sum
    hidden: yes
    sql: ${retail_price} ;;
  }

  measure: average_sale_price {
    type: average
    hidden: no
    sql: ${retail_price} ;;
  }
#cambio
  measure: percentage_change {
    type: percent_of_previous
    sql: ${average_sale_price} ;;


  }


}
