# docbot.rb

Your bot that helps you with Ruby Docs.

## Setup your environment

```sh
git clone https://github.com/filipebarcos/docbot.rb.git
cd docbot.rb/
script/setup
```

## Running the tests

```sh
script/test
```

## Configuring Docbot and your Environment Variables

You need to have your bot configured before we can start running the application (this is necessary only because we're not creating a Slack app). Just follow the [link to create a bot user](https://my.slack.com/services/new/bot) on your Slack org.

After that done, you can setup your environment variables. To do that, you could either set them inline when calling the script to run the app, or creating a `.env` file on the root of the project. An example is provided, so you can just copy it and fill up the values.
```sh
cp .env{.example,}
$EDITOR .env
```

## Running the Application

```sh
script/run
```

## Architectural decisions

1. Using RTM API over Web API: this decision was made from the beginning because with Web API, we would need to have this app deployed somewhere, like Heroku, so we could have an endpoint to Slack consume (post webhook notifications). This was kind of a deal breaker from the start.

2. Using Faye websocket gem: I used this gem just because I have used it in the past and think its API is simple to use and would get me up and running faster.

3. Testing with RSpec over Minitest/TestUnit: I simply like RSpec syntax better. I don't dislike using assertions, but I like the way RSpec let me organize and write my tests.

4. Extracting message logic to `Docbot::Message`: with this extraction I could have better and specific tests to cover all the possible messages that would trigger a documentation response from **Docbot**. Also, would be easier to extend the codebase, differently from if I have left it where we handle the general messages.

5. Using HTTParty: Besides it adding a new dependency to my project, HTTParty get it cleaner, instead of having to deal with HTTP/Net madness.

6. Namespaces: I tried to leave things separated by namespaces to make easier to know where to find things. Doing so, it's easy to know where to fix a bug around slack integration. Also, modularizing things makes easier to test and ensure my application works.

7. If you're interested in reading this code: Please, consider starting from `app.rb`. It is the running piece of the app, everything else is used "there".
