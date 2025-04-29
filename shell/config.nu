#     config nu --doc | nu-highlight | less -R

let base16_theme = {
  datetime:{ fg: white }
  separator:{ fg: black }                      # 表格列分隔符（|）的颜色
  leading_trailing_space_bg:{ fg: white }      # 行首/行尾多余空格的背景提示色
  header:{ fg: white }                         # 表头（列名）颜色
  empty:{ fg: blue }
  date:{ fg: white }                             # 日期类型颜色
  filesize:{ fg: white }                       # 文件大小（如 10kb）颜色
  row_index:{ fg: white }                      # 表格左侧行号颜色
  bool:{ fg: white }                           # 布尔值 true/false
  int:{ fg: white }                            # 整数值
  nothing:{ fg: white}
  duration:{ fg: white }                       # 时间间隔（如 2sec）
  range:{ fg: white }                          # 范围（如 1..10）
  float:{ fg: white }                          # 浮点数
  string:{ fg: "#676e95" }                     # 字符串内容显示颜色
  binary:{ fg: white }                         # 二进制数据
  cellpath:{ fg: white }                       # 表路径（如 $it.name）
  hints:{ fg: black }                          # 自动补全提示（灰色）
  record: default
  list: default
  closure: green_bold
  glob:cyan_bold
  block:{ fg: white }
  cell-path:{ fg:white }
  binary_null_char: grey42
  binary_printable: cyan_bold
  binary_whitespace: green_bold
  binary_ascii_other: purple_bold
  binary_non_ascii: yellow_bold


  shape_garbage:{ fg: red }                    # 语法错误（白字红底+粗体）
  shape_bool:{ fg: white }                     # 布尔值（语法层）
  shape_int:{ fg: white }                      # 整数（语法层，加粗）
  shape_float:{ fg: white }                    # 浮点数（语法层，加粗）
  shape_range:{ fg: white }                    # 范围表达式（1..10）
  shape_internalcall:{ fg: yellow }            # Nushell 内置命令（如 ls, cd）
  shape_external:{ fg: yellow }                # 外部命令（如 git, vim）
  shape_externalarg:{ fg: white }              # 外部命令参数（如 -l）
  shape_literal:{ fg: white }                  # 字面量值（固定值）
  shape_operator:{ fg: white }                 # 运算符（+ - == 等）
  shape_signature:{ fg: white }                # 函数/命令签名定义
  shape_string:{ fg: "#676e95" }               # 字符串（语法层）
  shape_filepath:{ fg: white }                 # 文件路径
  shape_globpattern:{ fg: white }              # 通配符（*.txt）
  shape_variable:{ fg: "#B766AD" }             # 变量（如 $env, $it）
  shape_flag:{ fg: white }                     # 命令 flag（如 --help）
  shape_custom: { fg: white }                  # 自定义高亮（扩展用）
}
$env.config.color_config = $base16_theme

$env.config.show_banner = false
$env.PROMPT_COMMAND_RIGHT = ""
$env.config.cursor_shape.emacs = "block"
$env.config.show_hints = true

$env.PROMPT_COMMAND = {||
  let home = (echo ~ | path expand)
  let pwd = $env.PWD | str replace $home "~"
  let segments = ($pwd | split row "/")
  let count = ($segments | length)

  let path = if $count <= 2 {
    $pwd
  } else {
    let last_two = ($segments | last 2)
    $"~/($last_two.0)/($last_two.1)"
  }

  let proxy = if ($env.http_proxy? | is-empty) and ($env.https_proxy? | is-empty) {
    ""
  } else {
    ""
  }

  let base01 = "#414559"
  let base02 = "#A0819D"
  let base03 = "#749395"
  let base04 = "#7F81AF"
  let FG1 = (ansi {fg: $base01})
  let BG1 = (ansi {bg: $base02})
  let FG2 = (ansi {fg: $base02})
  let BG2 = (ansi {bg: $base03})
  let FG3 = (ansi {fg: $base03})
  let BG3 = (ansi {bg: $base04})
  let FG4 = (ansi {fg: $base04})
  let RESET = (ansi reset)
  $"\n($FG1)($BG1) ($path) ($BG2)($FG2)($BG3)($FG3)($BG3)($FG1) ($proxy) ($RESET)($FG4)($RESET) "

}
$env.PROMPT_INDICATOR = {|| "" }

