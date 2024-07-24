library(OhdsiShinyModules)
library(ShinyAppBuilder)

shinyConfig <- initializeModuleConfig() |>
  addModuleConfig(
    createDefaultAboutConfig()
  )  |>
  addModuleConfig(
    createDefaultDatasourcesConfig()
  )  |>
  addModuleConfig(
    createDefaultCohortGeneratorConfig()
  ) |>
  addModuleConfig(
    createDefaultCharacterizationConfig()
  )

cli::cli_h1("Starting shiny server")
#server <- paste0(Sys.getenv("shinydbServer"), "/", Sys.getenv("shinydbDatabase"))
cli::cli_alert_info("Connecting to {server}")
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = "postgresql",
  server = Sys.getenv("shinydbServer"),
  port = Sys.getenv("shinydbPort"),
  user = "shinyproxy",
  password = Sys.getenv("shinydbPw")
)

cli::cli_h2("Loading schema")
createShinyApp(config = shinyConfig,
               connectionDetails = connectionDetails,
               resultDatabaseSettings = createDefaultResultDatabaseSettings(schema = "semanaion")
)