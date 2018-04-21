# create a topic keyword and variations. Keyword is a single word - string
# create questions that pertain to the topic and include details like
# the actual question, is it true or false, what is the answer, any supporting information
# and finally the topic it is associated with.

@topic1 = Topic.create(
            keyword: "flu", #keywords in lowercase
            description: "Discover the 5 myths on dealing with the flu"
          )

Question.create(
  detail: "You can catch the flu from the vaccine. (Reply T or F)",
  answer: "F",
  answer_description: "The flu vaccine that a person receives is an inactive virus that cannot be transmitted. Those that feel symptoms were already infected.",
  more_info: "https://www.health.harvard.edu/diseases-and-conditions/10-flu-myths",
  topic_id: @topic1.id
)

Question.create(
  detail: "Do you need a flu shot every year? (Reply T or F)",
  answer: "T",
  answer_description: "Flu viruses adapt quickly so the CDC recommends getting a flu vaccine yearly as the virus changes.",
  more_info: "https://www.cdc.gov/flu/about/qa/misconceptions.htm",
  topic_id: @topic1.id
)

Question.create(
  detail: "Pregnant woman should not get the flu shot. (Reply T or F)",
  answer: "F",
  answer_description: "That is a myth, pregnant woman should get the shot and in many cases the benefit will help the baby in the first months of his or her life.",
  more_info: "http://www.health.com/health/gallery/0,,20861838,00.html#pregnant-women-can-t-get-a-flu-shot-0",
  topic_id: @topic1.id
)

Question.create(
  detail: "You can keep the flu away by frequently washing your hands? (Reply T or F)",
  answer: "F",
  answer_description: "Washing your hands with warm soapy water is important, but it won't stop the flu. Influenza is spread through the air. More specifically, through saliva droplets from someone who is infected.",
  more_info: "http://www.health.com/health/gallery/0,,20861838,00.html#you-can-stop-the-flu-by-washing-your-hands-a-lot-0",
  topic_id: @topic1.id
)

Question.create(
  detail: "Does the flu vaccine weaken your body's immune response? (Reply T or F)",
  answer: "F",
  answer_description: "Actually the opposite. The vaccine stimulates the production of antibodies and strengthens the immune system.",
  more_info: "https://www.npr.org/sections/health-shots/2014/10/10/354627818/32-myths-about-the-flu-vaccine-you-dont-need-to-fear",
  topic_id: @topic1.id
)

# A second topic on heart disease.
@topic2 = Topic.create(
            keyword: "heart", #keywords in lowercase
            description: "Test your knowledge about heart disease."
          )

Question.create(
  detail: "Most Heart Attacks happen on a Monday. (Reply T or F)",
  answer: "T",
  answer_description: "Time of day, day of the week including the time of the year can have influences in cardiovascular wellness.",
  more_info: "http://circres.ahajournals.org/content/106/3/430",
  topic_id: @topic2.id
)

Question.create(
  detail: "You can die from a Broken Heart. (Reply T or F)",
  answer: "T",
  answer_description: "Broken heart syndrome is a real condition. It is a social condition that can affect your health.",
  more_info: "https://www.healthline.com/health-news/can-you-die-of-broken-heart#1",
  topic_id: @topic2.id
)

Question.create(
  detail: "In the U.S., someone suffers from a heart attack every 10 minutes. (Reply T or F)",
  answer: "F",
  answer_description: "According to the CDC, someone suffers from a heart attack every 40 seconds!",
  more_info: "https://www.cdc.gov/dhdsp/data_statistics/fact_sheets/fs_heart_disease.htm",
  topic_id: @topic2.id
)

Question.create(
  detail: "The most common day to have a heart attack is on Christmas day. (Reply T or F)",
  answer: "T",
  answer_description: "Cardiac deaths peak during this season and is most likely due to stress and overindulgences.",
  more_info: "http://circ.ahajournals.org/content/110/25/3744",
  topic_id: @topic2.id
)
