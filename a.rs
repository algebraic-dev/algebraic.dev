macro_rules! stack_operations {
    ($type:ty, $prefix:ident) => {
      pub fn $(stringify!($prefix, 2b))(&mut self) {
        let inner: $type = self.pop().into();
        self.push(MistValue::Byte(inner as i8));
      }
    };
  }