KNOWN ISSUES
============

* Changing shells while inside an environment (e.g. running 'bash' inside an
  env loaded under zsh) is unsupported and can result in chaos, expecially if
  you try and load another env inside the second shell.

* Given envs 'a.env.sh' and 'b/a.env.sh', 'b/a' cannot currently inherit from
  'a', because the absolute 'a' is incorrectly resolved as being a relative
  path to 'b/a'.

* No documentation exists.
