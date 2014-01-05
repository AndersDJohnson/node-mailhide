# Mailhide

Provides easy use of the [Google reCAPTCHA Mailhide][mailhide] [API][mailhideAPI].

## Install

```shell
npm install mailhide
```

## Usage

You will need a Mailhide API key, both public and private, which you can generate [here][mailhideAPIkey].

Then use as follows:

```javascript

var Mailhide = require('mailhide');
var mailhider = new Mailhide({
  privateKey: "9aa749cd1f9eece41df3e18010b922dd",
  publicKeyFile: __dirname + "/example.public.key"
});

var url = mailhider.url(email);

// url == "http://www.google.com/recaptcha/mailhide/d?k=01g4QpVFLdMs52QNMKC2tuCg%3D%3D&c=51q-FveskT4H19GHK6zDcohvqqiqWoicUgGIbE6QIUE%3D"
```

Also see "examples/example.coffee".


[mailhide]: http://www.google.com/recaptcha/mailhide/
[mailhideAPI]: https://developers.google.com/recaptcha/docs/mailhideapi
[mailhideAPIkey]: http://www.google.com/recaptcha/mailhide/apikey
