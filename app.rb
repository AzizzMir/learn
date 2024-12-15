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

set :public_folder, File.dirname(__FILE__) + '/public'

get("/") do
  @letters_with_audio = {
    'ئا' => '/audio/ئا.MP3', 
    'ئە' => '/audio/ئە.MP3',  
    'ب' => '/audio/ب.MP3', 
    'پ' => '/audio/پ.MP3', 
    'ت' => '/audio/ت.MP3', 
    'ج' => '/audio/ج.MP3', 
    'چ' => '/audio/چ.MP3', 
    'خ' => '/audio/خ.MP3', 
    'د' => '/audio/د.MP3', 
    'ر' => '/audio/ر.MP3', 
    'ز' => '/audio/ز.MP3', 
    'ژ' => '/audio/ژ.MP3', 
    'س' => '/audio/س.MP3', 
    'ش' => '/audio/ش.MP3', 
    'غ' => '/audio/غ.MP3', 
    'ف' => '/audio/ف.MP3',
    'ق' => '/audio/ق.MP3',
    'ك' => '/audio/ك.MP3', 
    'گ' => '/audio/گ.MP3', 
    'ڭ' => '/audio/ڭ.MP3', 
    'ل' => '/audio/ل.MP3', 
    'م' => '/audio/م.MP3', 
    'ن' => '/audio/ن.MP3', 
    'ھ' => '/audio/ھ.MP3', 
    'ئو' => '/audio/ئو.MP3', 
    'ئۇ' => '/audio/ئۇ.MP3', 
    'ئ‍ۆ' => '/audio/ئۆ.MP3', 
    'ئ‍ۈ' => '/audio/ئ‍ۈ.MP3', 
    'ۋ' => '/audio/ۋ.MP3', 
    'ئې' => '/audio/ئې.MP3', 
    'ئى' => '/audio/ئى.MP3', 
    'ي' => '/audio/ي.MP3'
  }

  erb(:index)
end

get("/vowels") do
  @vowels_with_audio = {
  'ئا' => '/audio/ئا.MP3', 
  'ئە' => '/audio/ئە.MP3', 
  'ئې' => '/audio/ئې.MP3', 
  'ئى' => '/audio/ئى.MP3', 
  'ئو' => '/audio/ئو.MP3', 
  'ئۇ' => '/audio/ئۇ.MP3', 
  'ئ‍ۆ' => '/audio/ئۆ.MP3', 
  'ئ‍ۈ' => '/audio/ئ‍ۈ.MP3'
  }

  erb(:vowels)
end

get("/consonents") do
  @consonents_with_audio = {  
    'ب' => '/audio/ب.MP3', 
    'پ' => '/audio/پ.MP3', 
    'ت' => '/audio/ت.MP3', 
    'ج' => '/audio/ج.MP3', 
    'چ' => '/audio/چ.MP3', 
    'خ' => '/audio/خ.MP3', 
    'د' => '/audio/د.MP3', 
    'ر' => '/audio/ر.MP3', 
    'ز' => '/audio/ز.MP3', 
    'ژ' => '/audio/ژ.MP3', 
    'س' => '/audio/س.MP3', 
    'ش' => '/audio/ش.MP3', 
    'غ' => '/audio/غ.MP3', 
    'ف' => '/audio/ف.MP3',
    'ق' => '/audio/ق.MP3',
    'ك' => '/audio/ك.MP3', 
    'گ' => '/audio/گ.MP3', 
    'ڭ' => '/audio/ڭ.MP3', 
    'ل' => '/audio/ل.MP3', 
    'م' => '/audio/م.MP3', 
    'ن' => '/audio/ن.MP3', 
    'ھ' => '/audio/ھ.MP3',  
    'ۋ' => '/audio/ۋ.MP3', 
    'ي' => '/audio/ي.MP3'
  }

  erb(:consonents)
end

get("/:letter") do
  @chosed_letter = params.fetch("letter")

  erb(:flexible_letter)
end

get("/:letter/:example_word") do
  @chosed_letter = params.fetch("letter")

 message_list.push({"role" => "user", "content" => "Show the pronunciation explanation of the #{@chosed_letter}, and make an example word in Uyghur language starts with #{@chosed_letter}"})



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
  
  erb(:show_example)
end
