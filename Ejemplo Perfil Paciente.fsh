//Ejemplo de perfil paciente. 

Alias: $CodigoPaises = https://hl7chile.cl/fhir/ig/CoreCL/StructureDefinition/CodigoPaises
Alias: $humanname-mothers-family = http://hl7.org/fhir/StructureDefinition/humanname-mothers-family
Alias: $VSTiposDocumentos = https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/VSTiposDocumentos
Alias: $VSCodigosComunaCL = https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/VSCodigosComunaCL
Alias: $VSCodigosProvinciasCL = https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/VSCodigosProvinciasCL
Alias: $VSCodigosRegionesCL = https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/VSCodigosRegionesCL
Alias: $CodPais = https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/CodPais

Profile: PacienteCl
Parent: Patient
Id: CorePacienteCl
Title: "Perfil Paciente Para Core Nacional"
Description: "Este Perfil ha sido desarrollado para cubrir las necesidades del Caso de Uso de Receta Electrónica. Sin embargo, se ha modelado con el fin de cubrir las necesidades nacionales de un Recurso Paciente para un Historial Clínico Nacional"
* ^version = "1.0.0"
* ^date = "2022-12-09T23:14:26-03:00"
* ^publisher = "HL7 Chile"
* ^contact.name = "HL7 Chile"
* ^contact.telecom[0].system = #url
* ^contact.telecom[=].value = "http://hl7chile.cl"
* ^contact.telecom[+].system = #email
* ^contact.telecom[=].value = "chair@hl7chile.cl"
* ^jurisdiction = urn:iso:std:iso:3166#CL "Chile"
* ^copyright = "Usado con el permiso de HL7 International, todos los derechos resevados en los Licencias de HL7 Internacional."
* extension ^short = "Extensión de Nacionalidad para pacientes extranjeros"
* extension ^definition = "Para hacer uso de esta extensión se debe agregar el path: extension.url = ´nacionalidad´"
* extension contains $CodigoPaises named nacionalidad 0..1
* identifier 1.. MS
* identifier ^short = "Listados de Id de Paciente. De poseer una CI con RUN vigente, este DEBE ser ingresado"
* identifier ^definition = "Este es el listado de Identificaciones de un paciente. Se procura como R2 el RUN, pero en caso de no existir ese identificador se debe ocupar otro nacional u otro otorgado por país extranjero"
* identifier ^comment = "En caso de que el paciente posea una CI con número RUN válido, este debe ser ingresado como identificador, independiente de que tenga otros identificadores, los cuales también pueden ser ingresados. La identificación implica el ingreso del tipo de documento, el país de origen de ese documento y ev valor del identificador"
* identifier.extension MS
* identifier.use = #official
* identifier.use MS
* identifier.use ^definition = "Se definirá este uso siempre como ´official´ debido a que cualquier ID presentado para motivos de este perfil deb ser de este tipo"
* identifier.use ^comment = "Se definirá como official pues en una primera etapa solo se considerarán los identidicadores en esa categoría. Para una segunda etapa se abrirá este elemento para cualquier clase de identificador"
* identifier.type MS
* identifier.type ^short = "Tipo de documento de Id (Extensible)"
* identifier.type ^definition = "Se define como tipo de documento de Id, aquel definido en el Sistema de Codificación V2-0203 de Hl7. Este sistema es extensible. Para pacientes sin documeto local deben especificar el de origen. Pacientes sin Id, deben usar el código MR = Local Medical Record, es decir numero del registro clínico abierto en el establecimiento"
* identifier.type ^comment = "De haber RUN, este se debe usar. De haber Run temporal, se debe usar ese identificador. Pacientes sin identificador Chileno deben usar su CI o Pasaporte de origen. Pacientes sin identificación se debe registrar con el numero de registro clínico generado en el recinto de salud"
* identifier.type.extension ^short = "País de Origen del Documento de Id"
* identifier.type.extension ^definition = "Se usa esta extensión para agregarle al tipo de documento el país de origen de este"
* identifier.type.extension contains $CodigoPaises named paises 1..1
* identifier.type.coding.system ^short = "Sistema de identificación de tipos de documentos"
* identifier.type.coding.system ^definition = "Sistema mediante el cual se obtienen los códigos para un determinado tipo de documento"
* identifier.type.coding.system ^comment = "En la URL del sistema se describe el set de códigos. Por ejemplo si se desea usar Cédula de identidad el código es NNxxx en donde xxx corresponde al identificador del país según la norma iso3166-1-N. Dado lo anterior si fuera Chile, el tipo de documento sería NNCL. En el Caso de Usar un Pasaporte este no requiere identificar país de origen dado que este es un elemento adicional, por lo que independiente del país el código será PPT según el VS indicado"
* identifier.type.coding.code from $VSTiposDocumentos (required)
* identifier.type.coding.code ^short = "Código de Tipo de Documento"
* identifier.type.coding.code ^definition = "Código de Tipo de Documento"
* name ^slicing.discriminator.type = #value
* name ^slicing.discriminator.path = "use"
* name ^slicing.description = "Este slice se genera para diferenciar el nombre registrado Versus el nombre social"
* name ^slicing.rules = #open
* name ^short = "Nombres y Apellidos del Paciente considerando, según el caso: 1er Nombre, Nombres, 1er Apellido y 2o Apellido"
* name ^definition = "Nombre del Paciente considerando, según el caso: 1er Nombre, Nombres, 1er Apellido y 2o Apellido"
* name contains
    NombreOficial 1..1 MS and
    NombreSocial 0..1 MS
* name[NombreOficial] ^short = "Determinación del nombre registrado oficialmente del Paciente"
* name[NombreOficial] ^definition = "Determinación del nombre registrado oficialmente del Paciente"
* name[NombreOficial].use 1..
* name[NombreOficial].use = #official
* name[NombreOficial].use ^short = "uso del nombre del paciente"
* name[NombreOficial].use ^definition = "este slice corresponde al nombre registrado al momento de nacer, por lo que se fuerza el valor ´official´"
* name[NombreOficial].use ^comment = "Para ser considerado como el slice determinado para el uso de nombre completo, el use DEBE ser de valor de código ´official´"
* name[NombreOficial].family 1..
* name[NombreOficial].family ^short = "1er Apellido"
* name[NombreOficial].family ^definition = "Se define el primer apellido registrado al momento de nacer o aquel que se ha inscrito legalmente en el Registro Civil"
* name[NombreOficial].family.extension ^short = "Extensión para 2o apellido"
* name[NombreOficial].family.extension ^definition = "Extensión para la declaracion de un segundo apellido"
* name[NombreOficial].family.extension contains $humanname-mothers-family named mothers-family 0..1
* name[NombreOficial].given 1..
* name[NombreOficial].given ^short = "Primer nombre y nombres del Paciente"
* name[NombreOficial].given ^definition = "Todos los nombres de los pacientes no necesariamente solo el Primer Nombre"
* name[NombreSocial] ^short = "nombre recurrente que usa el paciente"
* name[NombreSocial] ^definition = "Nombre con el cual se identifica al paciente sin ser este oficial. Se especifica slo en el uso del nombre"
* name[NombreSocial].use 1..
* name[NombreSocial].use = #usual
* name[NombreSocial].use ^short = "uso que se le da al nombre"
* name[NombreSocial].use ^definition = "Este uso especifico se enfoca a la definición de un nombre social. Es por esta razón que el uso se fuerza a usual"
* name[NombreSocial].use ^comment = "Para ser considerado como el slice determinado para el uso de nombre social, el use DEBE ser de valor de código ´usual´"
* name[NombreSocial].text ..0
* name[NombreSocial].family ..0
* name[NombreSocial].given 1..
* name[NombreSocial].given ^short = "Nombre Social"
* name[NombreSocial].given ^definition = "Nombre Social"
* name[NombreSocial].prefix ..0
* name[NombreSocial].suffix ..0
* name[NombreSocial].period ..0
* telecom MS
* telecom ^short = "Detalles de contacto del Paciente"
* telecom ^definition = "Detalles del contacto de un paciente comunmente el o los mas usados (Ej: Teléfono fijo, móvil, email, etc.)"
* telecom.system from ContactPointSystem (required)
* telecom.system ^definition = "Forma de telecomunicación para el punto de contacto: qué sistema de comunicación se requiere para hacer uso del contacto."
* telecom.value ^short = "Dato del contato del paciente descrito"
* telecom.value ^definition = "Valor del contacto como por ejemplo el numero de telefono fijo o de móvil o el email del Paciente"
* telecom.use from ContactPointUse (required)
* telecom.use ^short = "home | work | temp | old | mobile"
* telecom.use ^definition = "Propósito para el contacto que se ha definido"
* gender 1.. MS
* gender ^short = "Sexo de nacimiento Registrado, male | female | other | unknown (requerido)"
* gender ^definition = "Sexo de nacimiento Registrado"
* birthDate 1.. MS
* birthDate ^short = "Fecha de nacimiento del Paciente. El formato debe ser YYYY-MM-DD"
* birthDate ^definition = "Fecha de nacimiento del Paciente. El formato debe ser YYYY-MM-DD (Ej: 1996-08-21)"
* address MS
* address ^short = "Dirección del paciente"
* address ^definition = "Se definirá la dirección en una línea y se podría codificar en city la comuna, en district la provincia y en state la región"
* address.use 1.. MS
* address.use ^short = "Definición del tipo de domicilio home | work | temp | old (requerido)"
* address.use ^definition = "Se especifica el tipo de dirección notificada. Esto debe ser segun los códigos definidos por HL7 FHIR"
* address.line MS
* address.line ^short = "Calle o avenida, numero y casa o depto"
* address.line ^definition = "Aquí se escribe toda la dirección completa"
* address.city MS
* address.city from $VSCodigosComunaCL (required)
* address.city ^short = "Campo para Comuna de residencia"
* address.city ^definition = "Campo para Comuna de residencia. Se usa el valueSet de códigos de comunas definidos a nivel naciona."
* address.district MS
* address.district from $VSCodigosProvinciasCL (required)
* address.district ^short = "Campo para Provincia de Residencia"
* address.district ^definition = "Campo para Provincia de Residencia. Se usa el valueSet de códigos de provicias definidos a nivel naciona."
* address.state MS
* address.state from $VSCodigosRegionesCL (required)
* address.state ^short = "Campo para la Región"
* address.state ^definition = "Campo Región. Se usa el valueSet de códigos de regiones definidos a nivel naciona."
* address.country MS
* address.country from $CodPais (required)
* address.country ^short = "Campo para País de Residencia"
* address.country ^definition = "Campo para País de Residencia"

//Ejemplo de ValueSet

Alias: $CSCodigoDNI = https://hl7chile.cl/fhir/ig/CoreCL/CodeSystem/CSCodigoDNI
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

ValueSet: VSTiposDocumentos
Id: VSTiposDocumentos
Title: "Tipos de Documentos"
Description: "Tipos de Documentos para identificación según tabla HL7 V3 y CodeSystem local."
* ^url = "https://hl7chile.cl/fhir/ig/CoreCL/ValueSet/VSTiposDocumentos"
* ^version = "1.0.0"
* ^status = #active
* ^date = "2022-01-18T00:00:00-03:00"
* ^publisher = "HL7 Chile"
* ^contact.name = "HL7 Chile"
* ^contact.telecom[0].system = #url
* ^contact.telecom[=].value = "http://hl7chile.cl"
* ^contact.telecom[+].system = #email
* ^contact.telecom[=].value = "chair@hl7chile.cl"
* ^jurisdiction = urn:iso:std:iso:3166#CL "Chile"
* ^copyright = "Usado con el permiso de HL7 International, todos los derechos resevados en los Licencias de HL7 Internacional."
* include codes from system $CSCodigoDNI
* include codes from system $v2-0203