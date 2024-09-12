---
layout: post
title: Diff gerbers with git diff
---

Do you want to have git show you what changed on your gerbers?  My friend [Jason](http://www.jasonabeleconsulting.com/) shared his setup with me.

1. Tell git to use gerbv for diffs

`~/.gitconfig:`

```
[difftool]
    prompt = false

[difftool "gerbv"]
    cmd = "gerbv -a $LOCAL $REMOTE --background=#000000 --foreground=#ff000055 --foreground=#0000ff"
```

2. Recompile gerbv to default to CAIOR for rendering

```
diff --git a/src/main.c b/src/main.c
index 67a561b..58f0142 100644
--- a/src/main.c
+++ b/src/main.c
@@ -398,12 +398,7 @@ main(int argc, char *argv[])
     mainProject->execpath = g_path_get_dirname(argv[0]);
 
     /* set default rendering mode */
-#ifdef WIN32
-    /* Cairo seems to render faster on Windows, so use it for default */
     screenRenderInfo.renderType = GERBV_RENDER_TYPE_CAIRO_NORMAL;
-#else
-    screenRenderInfo.renderType = GERBV_RENDER_TYPE_GDK;
-#endif
 
     logToFileOption = FALSE;
     logToFileFilename = NULL;
```

Now you can do this

```
git difftool -t gerbv HEAD~2 -- Gerber/proto002-B_Cu.gbl
```

and see this
![]({{ site.baseurl }}/images/gerbdiff.png)
