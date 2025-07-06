/-
Copyright 2025 Sofia Rodrigues. All rights reserved.
Licensed under the Apache License, Version 2.0 as described in the file LICENSE.
-/
import VersoBlog

namespace Algebraic
namespace Templates

open Verso Genre Blog Site Syntax
open Output Html Template Theme

def css : String := "
"

def home : Template := do
  return {{
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>{{ (← param (α := String) "title") }}</title>
        <link rel="stylesheet" href="/static/style.css"/>
        {{← builtinHeader }}
      </head>
      <body>
        <div class="frame-box container">
          <div class="bottom">
            <img class="character" src="static/bottom.png"/>
          </div>
          <div>
            <img class="character top" src="static/top.png"/>
          </div>
        </div>
        <div class="overlay">
          <div class="center">
            <img src="static/haskell.png" />
            {{ (← param "content") }}
            <button class="frame-box painted">
              "See my blog"
            </button>
          </div>
        </div>
      </body>
    </html>
  }}
