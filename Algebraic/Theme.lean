/-
Copyright 2025 Sofia Rodrigues. All rights reserved.
Licensed under the Apache License, Version 2.0 as described in the file LICENSE.
-/
import VersoBlog
import Algebraic.Templates

namespace Algebraic
namespace Theme

open Verso Genre Blog Site Syntax
open Output Html Template Theme

def theme : Theme := { Theme.default with
  primaryTemplate := Templates.home,
}
