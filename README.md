# Coding Challenge


The URL Shortener will be a web application that will provides two primary
features:

1. Given a URL, it can generate a short URL
2. Given a previously-generated short URL, it can redirect you to the
corresponding original long URL.

Short URLs are based on a unique token, seven characters in length, consisting only of numbers and upper-case letters, excluding ambiguous characters (`1`/`I`/`L`, `5`/`S`, `0`/`O`/`D`, `8`/`B`, `U`/`V`/`W`).


## Task

Your tecnical limitation it will using: Rails 4 and Ruby 2.1.7

The dependencies are fairly minimal—e.g. SQLite is used for the database—so hopefully it should be easy to get everything going.

Once you have the basic application running, your first task will be to implement two new features:

  1) It is certainly possible that the short URLs will be transcribed by hand, and we want to accommodate common transcription ambiguities. The current code handles possible ambiguities by completely avoiding certain easily-confused characters in the short URL token (as shown in the README). In order to allow for a larger token-space, modify the code so that as many as possible of these ambiguous characters are allowed to be used in generating the short URL, but treat ambiguous characters in an incoming short URL request as equivalent—e.g. the letter “I” and the number “1” would be interchangeable during short URL token lookup. For example, if we generate the token O5FTX8I for a URL, that URL should be returned if O5FTX81 or 0SFTXBI or 05FTX81 is sent in.

  2) On the other hand, transcription errors should ideally not result in false results. Modify the code to have a “sparse URL token space”, ensuring that no two short URLs are allowed to differ by only one character. For example, the code should not be allowed to generate a short URL token of ABCD1234 if there is an existing short URL token of ABCX1234.

## Setup

```
gem install bundler
bundle install
rake db:migrate
rails server
```

... then hit http://localhost:3000 to see it in action.

## Testing

```
rake spec
```
