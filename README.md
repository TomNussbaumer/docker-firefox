# docker-firefox

**Quick and dirty proof of concept: running firefox in a docker container**

Well, yes, it works, but it wasn't that easy to get there. The firefox package doesn't pull in all it's dependencies, but just complains during runtime. And the following one I wasn't able to fix:

```
GLib-CRITICAL **: g_slice_set_config: assertion 'sys_page_size == 0' failed
```

There are various related bug reports, but no fix. Some of the Mozilla guys say it's just a warning. Come on - a warning that reads 'CRITICAL'? Nice.
