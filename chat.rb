
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

input = " "

while input != "bye"

  puts "Hello! How can I help you today?"
  puts "__________________________________________________"

  input = gets.chomp

  if input != "bye"
    message_list.push({"role" => "user", "content" => input})

    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
       model: "gpt-3.5-turbo",
       messages: message_list
     }
    )

    puts api_response.fetch("choices")[0].fetch("message").fetch("content")

    message_list.push({"role" => "assistant", "content" => api_response.fetch("choices")[0].fetch("message").fetch("content")})

    puts "_"*50
  end

end

puts "Goodbye! Have a great day!"
