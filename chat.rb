require "openai"

# Initialize the OpenAI client with the API key
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Initialize the message list with a system message
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  }
]

# Print the initial greeting
puts "Hello! How can I help you today?"
puts "-" * 50

# Start the loop to handle user input and responses
loop do
  # Get user input
  print "You: "
  user_input = gets.chomp

  # Break the loop if the user types "bye"
  break if user_input.downcase == "bye"

  # Add the user's message to the message list
  message_list << { "role" => "user", "content" => user_input }

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  # Extract the response message from the API response
  response_message = api_response.dig("choices", 0, "message", "content")

  # Print the assistant's response
  puts "Assistant: #{response_message}"
  puts "-" * 50

  # Add the assistant's response to the message list
  message_list << { "role" => "assistant", "content" => response_message }
end

# Print goodbye message when user types "bye"
puts "Goodbye!"
