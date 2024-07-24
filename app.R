library(OhdsiShinyModules)
library(ShinyAppBuilder)

config <- loadConfig("config.json")
schema <- "semanaion"
resultDatabaseSettings <- createDefaultResultDatabaseSettings(
  schema = schema
)

cli::cli_h1("Starting shiny server")
server <- paste0(Sys.getenv("shinydbServer"), "/", Sys.getenv("shinydbDatabase"))
cli::cli_alert_info("Connecting to {server}")
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = "postgresql",
  server = server,
  port = Sys.getenv("shinydbPort"),
  user = "shinyproxy",
  password = Sys.getenv("shinydbPw")
)

cli::cli_h2("Loading schema")
createShinyApp(config = config,
               connectionDetails = connectionDetails,
               resultDatabaseSettings = resultDatabaseSettings)