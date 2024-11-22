require "sinatra"
require "sinatra/reloader"
require "openai"
require "dotenv/load"


client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant to Uyghur language beginners."
  },
]

get("/") do
  @letters = ["ئا", "ئە", "ب", "پ", "ت", "ج", "چ", "خ", "د", "ر", "ز", "ژ", "س", "ش", "غ", "ف", "ج", "ك", "گ", "ڭ", "ل", "م", "ن", "ھ", "ئو", "ئۇ", "ئ‍ۆ", "ئ‍ۈ", "ۋ", "ئى", "ئې", "ي"]

  erb(:index)
end

get("/:letter") do
  @chosed_letter = params.fetch("letter")

  message_list.push({"role" => "user", "content" => "Make a example word in Uyghur language starts with #{@chosed_letter}"})

  

  api_response = client.chat( #chat method
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  choices = api_response.fetch("choices")
  first_choice = choices.at(0)
  message = first_choice.fetch("message")
  @content = message.fetch("content")

  erb(:flexible_letter)
end
