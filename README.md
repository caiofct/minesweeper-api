# MineSweeper API

A simple minesweeper api that can allows for sign-up, sign-in, create a grid, toogle a flag on a square, explore a square and also detects when a game is over or won.

**Project made using Rails 5.2 and Ruby 2.5.0**

**Tests made with rspec**

**To use the api you can follow the below postman documentation that describes all the available REST resources and endpoints**

https://documenter.getpostman.com/view/1681883/mines/RVuAA6Y1

This application is hosted on Heroku in the following url:

https://caio-minesweeper-api.herokuapp.com/

Below, are some examples to start using the api

To create a new user, you can do:

```sh
  curl -H "Content-Type: application/json" -X POST --form 'users[email]=example@mail.com' --form 'users[name]=Example User' --form 'users[password]=1q2w3e4r5t' https://caio-minesweeper-api.herokuapp.com/users
```

To authenticate(it will return your user's token), do:

```sh
curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com", "password":"asdfasdf"}' https://caio-minesweeper-api.herokuapp.com/authenticate
```

To create a grid, do:

```sh
curl -H "Authorization: [token]" -X POST --form 'grid[width]=10' --form 'grid[height]=10' --form 'grid[number_of_mines]=10' https://caio-minesweeper-api.herokuapp.com/grids
```

To run the project

```sh
$ bundle install
$ rails s
```

To run the tests

```sh
$ rspec
```

OR

```sh
$ bundle exec rake spec
```
