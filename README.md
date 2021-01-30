## Names

- Mitchell Susa, s3601130
- Tristan MacAulay, s3784828


## Highest Level Attempted

- 90+


## Time Sheet

|MITCHELL SUSA |                  |                                                                                                                                                |
|---------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| DATE          | DURATION (HOURS) | ACTIVITY                                                                                                                                       |
| TOTAL         | 58               |                                                                                                                                                |
| 13/04/2020    | 1                | Setting up Environment                                                                                                                         |
| 14/04/2020    | 2                | Discussion on Project and how we are going to approach it                                                                                      |
| 16/04/2020    | 5                | Initially creating forum, made ability to create post, and show all posts                                                                      |
| 24/04/2020    | 1                | Added ability to delete posts/topics/comments                                                                                                  |
| 25/04/2020    | 5                | Connected posts/topics/comments, so that you can navigate the website. Finished post function, improvement editing posts/topics/comments       |
| 1/05/2020     | 5                | Completed linking forum, added some new fields, made navigation easier, started working on filtering posts                                     |
| 3/05/2020     | 2                | Discussion on next steps for project, and how we are going to approach it                                                                      |
| 4/05/2020     | 1                | Worked on trying to get compatablity with docker and vagrant, because we are working on different ones.                                        |
| 6/05/2020     | 5                | Finished filtering for posts, and made them into buttons                                                                                       |
| 7/05/2020     | 1                | Worked on merging forum-new to betterui, fixed some bugs with the merge                                                                        |
| 7/05/2020     | 4                | Worked on sidebar for posts, also adjusted a lot of the css                                                                                    |
| 11/05/2020    | 3                | Worked on profile                                                                                                                              |
| 13/05/2020    | 4                | Worked on settings page, and fixed some bugs with usernames on posts/comments, also introduced deletion and editing of own posts/comments only |
| 15/05/2020    | 4                | Completed settings page functunality, including adding option to upload avatar and verification. Also added search bar functunality            |
| 16/05/2020    | 5                | Worked on footer, styling posts, attempting nested comments, styling comments, news pull down, and generic bug fixes                           |
| 17/05/2020    | 6                | Testing                                                                                                                                        |
| 18/05/2020    | 2                | Finished testing and did some commenting                                                                                                       |
| 20/05/2020    | 2                | Finished commenting, and helped with heroku deployment                                                                                         |



|TRISTAN       |                  |                                                                                                                                                |
|---------------|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| DATE          | DURATION (HOURS) | ACTIVITY                                                                                                                                       |
| TOTAL         | 41               |                                                                                                                                                |
| 14/04/2020    | 2                | Discussion on Project and how we are going to approach it                                                                                      |
| 15/04/2020    | 3                | Worked on creating vagrant enviroment that works also with docker, as well configuring git hub, this did not work so decided to work seperatly.|
| 17/04/2020    | 2                | Created users in the model, created a scaffold to be able to easily login                                                                      |
| 25/04/2020    | 2                | Merged Mitchells work with my own to allow for both post and signup functionality                                                              |
| 27/04/2020    | 2                | Created sessions, so users can login and signup.                                                                                               |
| 3/05/2020     | 2                | Discussion on next steps for project, and how we are going to approach it                                                                      |
| 4/05/2020     | 1                | Worked on trying to get compatablity with docker and vagrant, because we are working on different ones.                                        |
| 5/05/2020     | 3                | Worked on the structure for the posts page, learning how to use css                                                                            |
| 8/05/2020     | 1                | Worked on creating recent users adding new attribute to users model called login time                                                          |
| 10/05/2020    | 1                | Worked on user validations for when logging and signing up, changed visual structure of the header and added a container to the body           |
| 12/05/2020    | 2                | Worked on adding cookies, for password and email for when user is logging                                                                      |
| 13/05/2020    | 2                | Changed cookies to remember users sessions and email - no longer storing password as a cookie                                                  |
| 14/05/2020    | 2                | Changed format so user can view home page without logging in, as well neccesary warnings for when they do want to view something               |
| 16/05/2020    | 4                | Worked on configuring heroku to send emails using send grid                                                                                    |
| 17/05/2020    | 6                | Worked on sending an email that will instantly login the user, manually test the functionality to ensure user is logged by pressing the link   |
| 20/05/2020    | 3                | Tested each of my functionality                                                                                                                |
| 21/05/2020    | 2                | Configured heroku to test my work and Mitchell's work                                                                                          |
| 22/05/2020    | 1                | Made final adjustments and cleanup to the code                                                                                                 |

## Heroku Deployment URL


https://assignment-tristan-mitchell.herokuapp.com/


## Heroku Deployment Log

 
       For more information can be found in this article:
         https://devcenter.heroku.com/articles/rails-asset-pipeline#compile-set-to-true-in-production
       
###### WARNING:
       You set your `config.active_storage.service` to :local in production.
       If you are uploading files to this app, they will not persist after the app
       is restarted, on one-off dynos, or if the app has multiple dynos.
       Heroku applications have an ephemeral file system. To
       persist uploaded files, please use a service such as S3 and update your Rails
       configuration.
       
       For more information can be found in this article:
         https://devcenter.heroku.com/articles/active-storage-on-heroku
       
###### WARNING:
       We detected that some binary dependencies required to
       use all the preview features of Active Storage are not
       present on this system.
       
       For more information please see:
         https://devcenter.heroku.com/articles/active-storage-on-heroku
       
###### WARNING:
       No Procfile detected, using the default web server.
       We recommend explicitly declaring how to boot your server process via a Procfile.
       https://devcenter.heroku.com/articles/ruby-default-web-server
-----> Discovering process types
       Procfile declares types     -> (none)
       Default types for buildpack -> console, rake, web
-----> Compressing...
       Done: 39.4M
-----> Launching...
       Released v9
       https://assignment-tristan-mitchell.herokuapp.com/ deployed to Heroku

