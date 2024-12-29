***MoviesDatabaseApplication***

[![Build status](https://build.appcenter.ms/v0.1/apps/fdae8363-4a17-4243-ac07-187215c95d5e/branches/dev/badge)](https://appcenter.ms)

Description
This application showcases a comprehensive movie database using the data provided in the movies.json file. It includes the following features:

Features
List Options for Related Movies

Year
Genre
Directors
Actors
All Movies
Each of these options expands/collapses to show related values. For example, under "Genre," you might see Comedy, Action, and Sport as separate values. Tapping a value lists the movies associated with it.

Detailed Information Display

For Year/Genre/Directors/Actors, each value cell displays the respective field.
For All Movies, each value cell shows a thumbnail, movie title, language, and year.
Search Functionality

Users can search movies by title, genre, actor, or director.
For example, searching for "comedy" will display all movies containing "comedy" in the title, genre, actor, or director.
The search results display movie posters, titles, languages, and years.
Clearing the search reverts the UI to show the original list options (year/genre/directors/actors).
Movie Details

Tapping a movie displays detailed information, including the poster, title, plot, cast & crew, release date, genre, and rating.
Users can select a rating source (IMDB, Rotten Tomatoes, Metacritic) to view the rating value.
A custom UI control has been created to show the rating value.


How to Use
Explore Movies:

Tap on "Year," "Genre," "Directors," or "Actors" to expand the list and see the related values.
Tap on any value to see the list of movies associated with it.
Tap on "All Movies" to see all movies in the database.
Search Movies:

Use the search bar to find movies by title, genre, actor, or director.
View the search results with detailed movie information.
View Movie Details:

Tap on a movie to see its detailed information.
Select a rating source to view the movie's rating.
Getting Started
To get started with the application, clone the repository and open it in Xcode. Make sure to have the movies.json file in the project's bundle..

