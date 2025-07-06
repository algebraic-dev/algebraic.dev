/-
Copyright 2025 Sofia Rodrigues. All rights reserved.
Licensed under the Apache License, Version 2.0 as described in the file LICENSE.
-/
import VersoBlog
open Verso Genre Blog

open Verso.Genre.Blog (page_link blob Page)
open Verso Output Html

def Be : Html := {{ <div> "ata" </div> }}

def team : Html := {{
  <div>
  {{ #[("a", "b")].map fun (name, alt) =>
    {{<div class="person">
        {{ Be }}
        <h1 class="name">{{name}}</h1>
        <div class="name">{{alt}}</div>
      </div>
    }}
  }}
  </div>
}}


#doc (Post) "A Verso Site" =>

This is a quick demo of how to define and customize a Lean site using Verso.

Here's some <bold>bold</bold> text

:::blob team
:::

```leanInit demo
-- This block initializes a Lean context
```

```lean demo
example := if true then 1 else 2
example := if True then 1 else 2
example : Int := if True then 1 else 2
```
