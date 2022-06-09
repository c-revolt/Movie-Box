# **Movie Box**

This pet project loads data with films from the open API [tmdb](https://www.themoviedb.org). The user adds films to his collection, notes the films he has watched. Then the user receives an award for certain achievements, and also sees the counter of films he has watched.
The design idea for the project was inspired by:
- [Netflix App](https://apps.apple.com/kz/app/netflix-basic/id363590051?l=en)
- [This App](https://apps.apple.com/ru/app/what-to-watch-movie-guide/id1603876553?l=en)
- [This Template](https://dribbble.com/shots/14790000-Movie-Online-App/attachments/6496305?mode=media).
___

## **Stack**
- UIKit
- JSON
- URLSession
- SDWebImage
- Core Data
- MVVM

## App state
The application is currently being developed. Work is underway with both design and functionality.

What is done:
- [x] Home controller
- [x] Upcoming Controller
- [x] Search Controller
- [x] Collection Controller  
- [x] Preview Controller
- [x] one way to add movie
- [x] API requests
- [x] Poster, title, description, rating
- [x] Database storage
___
What should be done:
- [ ] Checkmark
- [ ] Achievements
- [ ] Adding a movie from a button
- [ ] User profile
- [ ] Notifications
- [ ] Controller preview design
- [ ] Country and release date
- [ ] Movies watched by users counter
___
Run at least **iOS15.0**

# **Overview**

## Main Controller
Here the user can view the movie categories. The header shows a random movie poster. 
The "TRAILER" and "IN THE BOX" buttons are not active at the moment. Also, the Profile and Notifications buttons are not yet active.

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox1.png" width="400">

### Add movie to box
The user can add the movie he likes to his collection (box).

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox3.png" width="400">

### Bugs
- Sometimes the Profile and Notifications buttons turn green when they should be white.

## Preview Controller
The Preview controller shows a more detailed description of the movie. The trailer is also loaded from YouTube using its [API](https://developers.google.com/youtube/v3). The trailer can be watched directly in the application. The button "In a Box" is not active yet. In the future, it is planned to add a title poster, country, cast and change the design of the button.

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox8.png" width="400">

## Upcoming Controller
This controller displays a list of future releases.

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox4.png" width="400">

## Search Controller
Movie search.

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox5.png" width="400"> <img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox6.png" width="400">

## User Box Controller
Movies that the user has added to his collection are stored here. Movies can be deleted and go to the review. Plans to add a checkmark. The user notes the films that he has watched and receives achievements in the future. Achievements will be issued to the user for a certain number of watched videos and for watching certain categories of films.

<img src="https://github.com/c-revolt/Movie-Box/blob/main/Screenshots/MovieBox7.png" width="400">
