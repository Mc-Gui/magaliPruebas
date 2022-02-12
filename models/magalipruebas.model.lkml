# Define the database connection to be used for this model.
connection: "thelook"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: magalipruebas_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


datagroup: datagroup_probando{
  label: "soy una etiqueta"
  description: "probando datagroup"
  max_cache_age: "5 hours"
  sql_trigger: SELECT (EXTRACT(MONTH FROM DATEADD( day, 1, GETDATE())));;
}

datagroup: envio_ultimo_dia_mes{
  sql_trigger: SELECT max(id) FROM  inventory_items;;
}

persist_with: datagroup_probando
#persist_for: "1 hour"

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Proyecto Copia"

explore: inventory_items {

  fields: [ALL_FIELDS*]

  join: products {
    type: left_outer
    foreign_key:inventory_items.product_id
    relationship: many_to_one
    fields: [-products.esteesunfiltro]
  }
}

explore: order_items {


  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }


  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one

  }
#------------muchos filtros--------------
  always_filter: {
    filters: [orders.statusss: "complete"]
  }

#  sql_always_where: ${orders.statusss}='complete' ;;

  #conditionally_filter: {
  # filters: [orders.statusss: "complete"]
  #unless: [products.brand]
  #}

}


explore: orders {
  fields:[ALL_FIELDS*,-orders.dependedeotravista]

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: product_facts {

  fields: [ALL_FIELDS*]#para el error de que no se encuentra el campo
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
    fields: [-products.esteesunfiltro]#para el error de que no se encuentra el campo
  }

}


# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: products {
fields: [ALL_FIELDS*,-products.esteesunfiltro]#para el error de que no se encuentra el campo
}

explore: productsDeMujer {
  from: products
   sql_always_where: productsDeMujer.department={% parameter productsDeMujer.parafiltrarconparametro %};;#va el nombre del explore
  fields: [ALL_FIELDS*,-productsDeMujer.esteesunfiltro,-productsDeMujer.category]
}

explore: users_filtrados {
  from: users
  sql_always_where: DATE_TRUNC('year', {% parameter users_filtrados.filtrodefecha %}) <=${users_filtrados.created_date}
    and  ${users_filtrados.created_date}<={% parameter users_filtrados.filtrodefecha %} ;;#va el nombre del explore
}

explore: users {}
