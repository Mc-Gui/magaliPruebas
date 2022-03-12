project_name: "magalipruebas"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
 local_dependency: {
   project: "proyecto_copia_magali"
  override_constant: connection  {
    value: "thelook"
  }
  override_constant: schema {
    value: "public"
  }
}

constant: connection {
  value: "thelook"
}


constant: schema {
  value: "public"
}
