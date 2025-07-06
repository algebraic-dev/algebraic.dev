/-
Copyright 2025 Sofia Rodrigues. All rights reserved.
Licensed under the Apache License, Version 2.0 as described in the file LICENSE.
-/
import VersoBlog

namespace Algebraic
namespace Templates

open Verso Genre Blog Site Syntax
open Output Html

def header : Html := {{
  <ul class="header">
    <li>"HOME"</li>
    <li>"CONTACT"</li>
    <li>"BLOG"</li>
  </ul>
}}
