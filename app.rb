require "sinatra"
require "sinatra/reloader"
require "openai"
require "dotenv/load"
require "cgi"


client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant to Uyghur language beginners."
  },
]

get("/") do
  @letters = ["ئا", "ئە", "ب", "پ", "ت", "ج", "چ", "خ", "د", "ر", "ز", "ژ", "س", "ش", "غ", "ف", "ج", "ك", "گ", "ڭ", "ل", "م", "ن", "ھ", "ئو", "ئۇ", "ئ‍ۆ", "ئ‍ۈ", "ۋ", "ئى", "ئې", "ي"]
  @vowels = ["ئا", "ئە", "ئې", "ئى", "ئو", "ئۇ", "ئ‍ۆ", "ئ‍ۈ"]
  @consonents = @letters - @vowels

  erb(:index)
end

get("/vowels") do
  @vowels = ["ئا", "ئە", "ئې", "ئى", "ئو", "ئۇ", "ئ‍ۆ", "ئ‍ۈ"]

  erb(:vowels)
end

get("/consonents") do
  @consonents = ["ب", "پ", "ت", "ج", "چ", "خ", "د", "ر", "ز", "ژ", "س", "ش", "غ", "ف", "ج", "ك", "گ", "ڭ", "ل", "م", "ن", "ھ", "ۋ", "ي"]

  erb(:consonents)
end

get("/:letter") do
  @chosed_letter = params.fetch("letter")

  erb(:flexible_letter)
end

get("/:letter/:example_word") do
  @chosed_letter = params.fetch("letter")

#  message_list.push({"role" => "user", "content" => "Show the pronunciation explanation of the #{@chosed_letter}, and make an example word in Uyghur language starts with #{@chosed_letter}"})



#   api_response = client.chat( #chat method
#     parameters: {
#       model: "gpt-3.5-turbo",
#       messages: message_list
#     }
#   )

#   choices = api_response.fetch("choices")
#   first_choice = choices.at(0)
#   message = first_choice.fetch("message")
#   @content = message.fetch("content")

  @content = "This is for testing!"
  
  erb(:show_example)
end
