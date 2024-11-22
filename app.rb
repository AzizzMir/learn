require "sinatra"
require "sinatra/reloader"

get("/") do
  @letters = ["ئا", "ئە", "ب", "پ", "ت", "ج", "چ", "خ", "د", "ر", "ز", "ژ", "س", "ش", "غ", "ف", "ج", "ك", "گ", "ڭ", "ل", "م", "ن", "ھ", "ئو", "ئۇ", "ئ‍ۆ", "ئ‍ۈ", "ۋ", "ئى", "ئې", "ي"]

  erb(:index)
end

get("/:letter") do
  @chosed_letter = params.fetch("letter")

  erb(:flexible_letter)
end
