# QuizBot [![CircleCI](https://circleci.com/gh/robotscissors/quizbot.svg?style=svg)](https://circleci.com/gh/robotscissors/quizbot)

QuizBot is an application that is lightweight and uses Twillio’s SMS features. It does one thing – it engages users with quizzes. The inspiration for this is marketing. Picture yourself sitting in a waiting room or in an exam room at your doctor’s office. Printed on a poster stuck to the wall, you read “Find out more about your risks of heart disease. Text HEART to xxx-xxx-xxxx to test your knowledge about heart disease.”

In addition to entertaining patients at the point of service, it gives you the opportunity to combine these opted-in users into other campaigns further down the road.

## The Thing You Will Need to Get Started
Before you can do anything, you will need to open an account with Twilio. The trial version is free. Here is a small demo on signing up, choosing a number and a brief description on [SMS inbound and outbound](https://www.youtube.com/watch?v=8SLdV8dn7_I).

Keep in mind that while you are setting up, configuring and testing this application all of your text messages from this trial account to users will be prepended by: “Sent from your Twilio trail account – “. After you test the application, then you can update the payment information in your Twilio account and the demo "Twilio Trial Account" message will disappear.

## Let's Get Sinatra Set Up
1. First thing you need to do is **clone** the repository.
2. Run ```bundler install``` to bring in all the gems.

>Side note: this application uses Postgres as the database portion and it can be tricky to install locally. I found this article quite helpful if you get into a jam: https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb 

3. Finally if you managed to get everything installed, spin up sinatra by running the application ```ruby app.rb``` and the webserver should start letting you know it is listening on port 4567.

4. Next, open a browser and go to ```http://localhost:4567``` and you should see the message: **QuizBot is on center stage with Sinatra.** If you see this message, then you are half way home!

## Database Setup Required
You are going to need some enviroment variables to allow you to access the database and use Twilio. In the config folder of your application create a file named:
  ```env.yml```
This file works with the [envyable gem](https://rubygems.org/gems/envyable/versions/0.2.0) that was installed when you ran bundle install.

Inside that file, put the following information (I have delibertly put x's where the information should be). All the Twilio information can be obtained by going back into your twilio account. The database information will be all the info for your local machine.

```
  development:
    TWILIO_ACCOUNT_SID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    TWILIO_AUTH_TOKEN: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    TWILIO_PHONE_NUMBER: '+1xxxxxxxxxx'
    PG_USER: [whatever your local username is]
    PG_PASS:
```

## OK, Let's create the database
In the console type:
  ```
  rake db:create
  rake db:migrate
  ```

These two commands will create the database and it will also create the tables to keep track of the questions, the scores and any other information that is important to the quiz.

Finally, let's load the demo quiz into the database to help you get started. The quiz information and structure is created in a seed file that is located in the db folder. The structure of this file is described further down.

To load the demo quiz, type in the console:

  ```rake db:seed```

If everything passes, then the quiz has fully loaded and you are almost there!

## Final Step. Let's Wire It All Together!
So, how do do we actually get our machine to respond to a text? 

The video in the first step does a good job of quickly explaining how someone sending a text to our number reaches our application. Essentially, anyone sending a text to our Twilio number will generate a ```POST``` to the ```/sms``` route in our sinatra application. Our application will then capture the information in the parameters and respond accordingly.

Since you are probably working on your local machine to test and configure the application, you will need something like:
  [ngrok](https://ngrok.com/)

This lightweight application will generate a URL that, once your Sinatra application is up and running, **ngrok** will create an external URL that will allow public access. You'll need that if you want to test your application. Of course once you move into production and use a webserver like Heroku, all you'll need is the webaddress of the server.

Once you have downloaded ngrok at the command line, type:
    ```ngrok http 4567```
This command will create a tunnel your application running on port 4567 to the outside world.

![Image of ngrok webaddress](https://imgur.com/a/kmBOIqS)

What you are looking for is the address that is marked **forwarding**.
 
 




  



