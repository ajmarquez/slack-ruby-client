require 'slack-ruby-client'

class ReactionList
  attr_accessor :array

  def initialize(array = [])
    @array = array
  end

  def remove(object=0)
    @array.delete(object)
  end

  def clear
    @array = []
  end

  def show
    @array.join(' ')
  end




end




Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

main = ReactionList.new(0)


main_channel = 0

#----- WHEN USER WRITES
client.on :message do |data|
  puts data
  client.typing channel: data['channel']



  case data['text']

  ## TO ADD A REACTION LIST, GOES THIS WAY
  ## User must use the special word "track" and add their reactions

  when /^[tT]rack (?<reactions>.*)$/ then
    ## Then match[:reactions] must be created into an array of reactions
    tracked_reactions = /^[tT]rack (?<reactions>.*)$/.match(data['text'])['reactions'].strip.split(" ")
    main.array = tracked_reactions
    client.message channel: data['channel'], text: "I'm phil-in your reactions!"
    main_channel = data['channel']

   #when /^[rR]emove (?<reactions>.*)$/ then
   #TO DO
   #Then another array is created and compared with the Main Reaction array, if matched delete from array. If not found, tell the use
   #client.message channel: data['channel'], text: "Reactions removed" # To be modified


  when 'show reactions' then
    ## Puts reactions being tracked
    client.message channel: data['channel'], text: "I'm keeping a eye on ---> #{main.show}"
  when 'hello philbot' then
    client.message channel: data['channel'], text: "Hi <@#{data['user']}>!, don't overREACT, ok?"
  when 'reset' then
    ## Delete reactions array
    main.clear
    puts "bye"

  end
end


#----- WHEN REACTION IS added
client.on :reaction_added do |data|

dummy_list = []

if main_channel!=0 then

  r_message = client.web_client.reactions_get(channel: main_channel, timestamp: data['item']['ts']) #Reacted message
  r_reactions = r_message['message']['reactions'] #Reactions from reacted message
  r_reactions.each do |item|
  dummy_list.push(":#{item['name']}:")

end

 if dummy_list.sort == main.array.sort then

 puts "THEY MATCH!"
client.message channel: main_channel, text: "And it's a match! http://i.imgur.com/QTGAq6N.gif "
else

  puts "No match."

 end

  puts dummy_list
  puts "X"
  puts main.array

end

end


#To execute copy and paste this
# SLACK_API_TOKEN=xoxb-10237477606-qCNwWBSnmWiIvoVcWzPxorXm  bundle exec ruby philbot.rb


client.start!
