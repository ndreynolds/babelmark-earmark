# babelmark-earmark

This is a [babelmark3][babelmark3] Markdown provider for [Earmark][earmark] (an
Elixir Markdown implementation).

It accepts requests with Markdown content in the format specified by
[babelmark-registry][babelmark3-registry], and responds with a payload
containing the HTML rendered by Earmark. For example:

```bash
$ curl http://localhost:4000/render?text=**Hello,%20World!**
> GET /render?text=**Hello,%20World!** HTTP/1.1
> Host: localhost:4000
> User-Agent: curl/7.59.0
> Accept: */*
>
< HTTP/1.1 200 OK
< cache-control: max-age=0, private, must-revalidate
< content-length: 85
< content-type: application/json
< date: Mon, 01 Apr 2019 00:38:37 GMT
< server: Cowboy
<
* Connection #0 to host localhost left intact
{"html":"<p><strong>Hello, World!</strong></p>\n","name":"Earmark","version":"1.3.2"}
```

Run it yourself:

```bash
mix deps.get
mix run --no-halt
```

[earmark]: https://github.com/pragdave/earmark
[babelmark3]: https://babelmark.github.io/
[babelmark3-registry]: https://github.com/babelmark/babelmark-registry
