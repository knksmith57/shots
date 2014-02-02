Self-Hosted Screenshots (SHOTS)
===============================

This is what happens when I get [an idea in my head](https://twitter.com/knksmith57/status/429753613615788032) and simultaneously want to pick up a new skill set.

Enter SHOTS, the extremely-terribly rough start to, what will soon become a, clean, usable, self-managed image service. Boom, commas.


## Quickstart

```
# duh
$ git clone https://github.com/knksmith57/shots

# do some weird ruby install shit
$ cd shots && bundle install

# use weird make tool to setup database
$ rake db:migrate

# create an API token
$ rake token:new | pbcopy

# SPIN IT UP BRO
$ ruby app.rb &

# upload a new image
$ curl --include --header "X-TOKEN: token_from_pbpaste" --form file=@some_image.png http://localhost:8080/add

# check it out
$ open http://localhost:8080/returned_image_id_here
```


## Notes

1. I'm a little drunk right now
2. This is my first hack at a sinatra app
3. LOLOL @ [`main.css`](public/css/main.css)

