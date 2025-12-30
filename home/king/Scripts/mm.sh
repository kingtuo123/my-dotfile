#!/bin/bash

if [[ $# -eq 0 ]];then
	cat << EOF
███╗   ███╗██╗   ██╗    ███╗   ███╗ █████╗ ███╗   ██╗    ██╗
████╗ ████║╚██╗ ██╔╝    ████╗ ████║██╔══██╗████╗  ██║    ██║
██╔████╔██║ ╚████╔╝     ██╔████╔██║███████║██╔██╗ ██║    ██║
██║╚██╔╝██║  ╚██╔╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║    ╚═╝
██║ ╚═╝ ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║    ██╗
╚═╝     ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═╝
EOF
	exit 0
elif [[ $1 =~ ^[^a-zA-Z] ]];then
	echo "Man! What Can I Say: '$1' Invalid Option"
	exit 1
else
	cmd=$1
fi




syntax() {
	echo -e "\n\t\e[1;33m$1\e[0m"
}

title() {
	echo -e "\n\t\e[1;37m$1\e[0m"
}

opts() {
	if [[ ${#1} -le 5 ]];then
		echo -e "\t\e[1;34m$1\e[0m\t$2"
	else
		echo -e "\t\e[1;34m$1\e[0m\n\t\t$2"
	fi
}

what_can_i_say() {
	if [[ "my-$cmd" == $(declare -F "my-$cmd") ]]; then
		eval "my-$cmd"
		echo ""
	else
		echo "Man! What Can I Say: '$cmd' Not Found"
		exit 1
	fi
}

trap what_can_i_say EXIT




my-sed() {
	syntax "sed [选项] '[地址]命令' 文件"
	title  "选项"
	opts   "-n" "禁止自动打印，sed 每处理一行会自动打印一行，所以一般搭配 p 命令使用"
	opts   "-e" "多重命令，例如：sed -e 's/foo/bar/' -e 's/baz/qux/' file.txt"
	opts   "-i" "直接修改文件内容"
	opts   "-r 或 -E" "使用扩展正则表达式"
	title  "地址（行定位）"
	opts   "n" "第 n 行"
	opts   "n,m" "第 n 到 m 行"
	opts   "n,+m" "第 n 到 n+m 行"
	opts   "n~m" "从第 n 行开始，每隔 m 行匹配一次"
	opts   "$" "最后一行"
	opts   "/pattern/" "包含 pattern 的行，pattern 是正则表达式"
	opts   "/start/,/end/" "包含 start 的行到包含 end 的行"
	opts   "n,/end/" "第 n 行到包含 end 的行"
	opts   "!" "对地址取反，表示不匹配的行，例如：sed -i sed '1,3!d' file.txt 只保留 1 到 3 行，删除其它行"
	title  "命令"
	opts   "s" "替换文本，格式：s/旧文本/新文本/[标志]，标志：g 全局替换，i 忽略大小写，p 打印替换后的行"
	opts   "d" "删除行"
	opts   "p" "打印行"
	opts   "i" "在指定行上方插入新行及文本，如 sed '2i newline' file.txt"
	opts   "a" "在指定行下方插入新行及文本"
	opts   "c" "替换整行内容"
	opts   "=" "打印当前行行号"
}


my-sort() {
	title "排序控制"
	opts  "-d" "默认，按照字典顺序排序（排序非数字文本），从左到右逐个字符比较 ASCII 值，如 1, 10, 2, 20, 3, 4"
	opts  "-n" "按照数值大小排序（排序纯整数数据），如 1, 2, 3, 4, 10, 20"
	opts  "-g" "按照常规数值排序（支持浮点数和科学计数的数值）"
	opts  "-M" "按照月份名称排序（JAN, FEB 等）"
	opts  "-b" "忽略行首的空白字符"
	opts  "-f" "忽略大小写"
	opts  "-i" "忽略不可打印字符"
	opts  "-R" "随机排序"
	opts  "-r" "逆序排序"
	opts  "-V" "按照版本号排序"
	title "字段处理"
	opts  "-k" "指定排序的键（字段）位置，如 sort -k2 data.txt 按第二列排序（默认空格分隔）"
	opts  "-t" "指定字段分隔符，如 sort -n -t: -k3 /etc/passwd"
	title "输出控制"
	opts  "-u" "去除重复行（相当于 uniq）"
}


my-awk() {
	syntax "awk [选项] '[表达式] { 语句1; 语句2; ... }' 文件"
	title  "选项"
	opts   "-F" "指定分隔符（默认为空格或制表符），使用 \$n 引用字段，\$0 表示整个字段"
	opts   "-v" "定义变量，例如：awk -v var=123 '{print \$1+var}' file.txt"
	title  "表达式（行定位）"
	opts   "/pattern/" "包含 pattern 的行（正则匹配），例如：awk '/error/ { print \$0 }' file.txt"
	opts   "\$n ~ /pattern/" "第 n 列包含 pattern 的行"
	opts   "\$n !~ /pattern/" "第 n 列不包含 pattern 的行"
	opts   "\$n > 10" "第 n 列大于 10 的行，例如：awk '\$1 > 10 { print \$0 }' file.txt，还有 < <= > >= != =="
	opts   "\$n == \"abc\"" "第 n 列等于 abc 字符串的行"
	opts   "\$n > 10 && \$n < 20" "第 n 列大于 10 小于 20 的行，还有 ||"
	opts   "\$1 + \$2 > 10" "第 1、2 列的和大于 10 的行，还有 + - * / % 等"
	title  "内置变量"
	opts   "NF" "当前行的字段数"
	opts   "NR" "当前处理的行号"
	opts   "FS" "字段分隔符（默认空格或制表符），即命令行的 -F 选项，可在脚本中修改"
	opts   "OFS" "输出字段分隔符（默认空格），当 OFS=\":\"，print \$1,\$2,\$3 输出类似 a:b:c"
	opts   "RS" "记录分隔符（默认换行符），即一个换行符被 awk 识别为一行进行处理"
	opts   "ORS" "输出记录分隔符（默认换行符），即输出的每行末尾是换行符"
	title  "内置函数"
	opts   "length(string)" "返回字符串的长度"
	opts   "tolower(string)" "转化为小写，还有 toupper"
	opts   "int(x)" "返回整数部分，还有 sqrt 平方根、log 对数等"
	opts   "systime()" "返回当前时间的时间戳"
	opts   'strftime(fmt, timestamp)' '将时间戳转化为格式化字符串，如 strftime("%Y-%m-%d %H:%M:%S", systime())'
	opts   "asort(array)" "对数组进行排序，并返回数组的长度"
}


my-grep() {
	syntax "grep [选项] '正则表达式' 文件"
	title  "基本搜索"
	opts   "-i" "忽略大小写"
	opts   "-v" "反向匹配，输出不包含匹配字符串的行"
	opts   "-w" "匹配整个单词，如 grep -w 'word' file.txt 不会匹配 words"
	opts   "-x" "匹配整行，如 grep -x 'exact line' file.txt 只匹配完全等于 exact line 的行"
	title  "输出控制"
	opts   "-c" "统计匹配的行数"
	opts   "-n" "显示匹配行的行号"
	opts   "-o" "只输出匹配的部分，而不是整行"
	opts   "-q" "静默模式，不输出任何内容，仅通过退出状态码表示是否匹配成功"
	title  "文件操作"
	opts   "-r 或 -R" "递归搜索目录中的文件，如 grep -r 'pattern' /path/to/dir"
	opts   "--include" "指定要搜索的文件类型，如 grep -r 'pattern' /path/to/dir --include '*.txt'"
	opts   "--exclude" "排除特定文件类型"
	opts   "-l" "输出文件中包含匹配字符串的文件名，如 grep -l 'pattern' *.txt 输出包含 pattern 的 .txt 文件名"
	opts   "-L" "输出文件中不包含匹配字符串的文件名"
	title  "正则表达式"
	opts   "-E" "使用扩展正则表达式（等同于 egrep 命令）；默认是基本正则表达式，不支持 + ? () {} 等"
	opts   "-F" "不解析正则表达式（等同于 fgrep 命令），视为普通字符串进行匹配"
	opts   "-P" "使用 Perl 兼容的正则表达式（PCRE），支持 \\d \\w \\s 等"
	title  "上下文控制"
	opts   "-A" "显示匹配行及其后面的 n 行，如 grep -A 2 'pattern' file.txt"
	opts   "-B" "显示匹配行及其前面的 n 行"
	opts   "-C" "显示匹配行及其前后各 n 行"
	title  "其他选项"
	opts   "--color" "高亮显示匹配的部分"
	opts   "-e" "多重匹配，如 grep -e 'pattern1' -e 'pattern2' file.txt"
}
