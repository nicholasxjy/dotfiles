local M = {}

M.kind_icons = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  Enummember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  ["Function"] = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  Typeparameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

M.misc = {
  dots = "󰇘",
}
M.ft = {
  octo = "",
}
M.dap = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}
M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
M.git = {
  added = " ",
  modified = " ",
  removed = " ",
}
return M
