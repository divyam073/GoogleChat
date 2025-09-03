# set environment variable
Sys.setenv("GEMINI_API_KEY" = "Your_Gemini_API_Key_Here")

# get api key
api_key = Sys.getenv("GEMINI_API_KEY")

# define the Google Search tool
#' Fetches data from Google Search API
#' 
#' @param query A string representing the search query.
#' @return The search results as string.
google_search_tool <- function(query) {
  resp <- gemini.R::gemini_search(query)
  resp <- gsub("\n","", resp)[[1]]
  return(resp)
}

# test Google Search tool
google_search_tool("what is today's date?")
# [1] "Today is Wednesday, September 3, 2025."

# register the Google Search tool
chat <- ellmer::chat_google_gemini(model = "gemini-2.5-flash",
                    api_key = api_key)

chat <- chat$register_tool(
  ellmer::tool(
    google_search_tool,
    name = "google_search_tool",
    description = "Fetches data from Google Search API",
    arguments = list(query = ellmer::type_string("The search query"))
))

# launch chatbot with Shiny interface
shinychat::chat_app(chat)
