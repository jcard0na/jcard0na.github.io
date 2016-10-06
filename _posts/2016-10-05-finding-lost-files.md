---
layout: post
title: Finding lost files
---

After looking for hours (well, maybe 10 minutes) for a lost file in my drive, I realized that ```find``` is what I needed:

```bash
find . -name '*.txt' -mtime -30d
```

(This gives us all the text files that were modified less than 30 days ago)
