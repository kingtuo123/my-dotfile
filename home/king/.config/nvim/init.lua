local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "         -- 设置空格为 <leader> 键 
vim.opt.termguicolors = true  -- 启用真彩色支持

require("lazy").setup({
--------------------------------------------------[[  everforest 颜色主题 ]]--------------------------------------------------
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "medium",
			})
			require("everforest").load()
		end,
	},
--------------------------------------------------[[     mini.nvim     ]]--------------------------------------------------
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.indentscope').setup({
				draw = {delay = 100},
				symbol = '|'
			})
		end,
	},
--------------------------------------------------[[     页面平滑滚动     ]]--------------------------------------------------
	{
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup()
		end
	},
--------------------------------------------------[[     语法高亮优化     ]]--------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"
	},
--------------------------------------------------[[    显示颜色#666666   ]]--------------------------------------------------
	{
		'brenoprata10/nvim-highlight-colors',
		config = function() require('nvim-highlight-colors').setup({}) end
	},
--------------------------------------------------[[     文件搜索     ]]--------------------------------------------------
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				defaults = { 
					initial_mode = "normal",
					mappings = {
						i = {
							["<A-->"] = require('telescope.actions').select_horizontal,
							["<A-\\>"] = require('telescope.actions').select_vertical,
						},
						n = {
							["l"] = require('telescope.actions').select_default,
							["<A-->"] = require('telescope.actions').select_horizontal,
							["<A-\\>"] = require('telescope.actions').select_vertical,
						}
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
					},
				}
			})
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<A-f>',      builtin.find_files, {})
			vim.keymap.set('n', '<A-g>',      builtin.live_grep, {})
			vim.keymap.set('n', '<A-b>',      builtin.buffers, {})
			vim.keymap.set('n', '<A-h>',      builtin.help_tags, {})
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>b',  builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end
	},
--------------------------------------------------[[     显示搜索索引     ]]--------------------------------------------------
	{ 
		"kevinhwang91/nvim-hlslens",
		config = function ()
			require("hlslens").setup({
				calm_down = true,			  -- 光标移出匹配项后取消高亮
				nearest_only = true,          -- 只显示当前匹配项的索引
				nearest_float_when = 'auto'   -- 浮动窗口显示时机: 'always', 'auto'
			})
			local kopts = {noremap = true, silent = true}
			vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		end
	},
--------------------------------------------------[[      底部状态栏      ]]--------------------------------------------------
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = {
					theme = 'auto',
					icons_enabled = false,
					globalstatus = true, -- 全局状态栏，有多个窗口时只显示最底下的状态栏
				},
				sections = {
					lualine_a = {'mode'},
					--lualine_b = {'filename', path = { 1 }, },
					lualine_b = {
						{ 'filename', path = 1 } -- 显示如 "lua/config/lualine.lua"
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {'progress'},
					lualine_z = {'location'},
				}
			})
		end
	},
--------------------------------------------------[[ 高亮当前窗口的分界线 ]]--------------------------------------------------
	{
	  "nvim-zh/colorful-winsep.nvim",
	  config = true,
	  event = { "WinLeave" },
	},
})



vim.opt.title          = true           -- 启用标题
vim.opt.titlestring    = "nvim @ %F %m"    -- 标题格式
vim.opt.number         = true           -- 显示行号
vim.opt.relativenumber = true           -- 相对行号
vim.opt.expandtab      = false          -- 禁止替换 tab 为空格
vim.opt.shiftwidth     = 4              -- 缩进宽度
vim.opt.tabstop        = 4              -- tab 显示宽度
vim.opt.autoindent     = true           -- 自动缩进
vim.opt.wrap           = false          -- 超出屏幕宽度的代码是否可见
vim.opt.cursorline     = true           -- 高亮光标所在行
vim.opt.cursorcolumn   = true           -- 高亮光标所在列
vim.opt.scrolloff      = 3              -- 滚动保留行数
vim.opt.splitright     = true           -- 默认新窗口右
vim.opt.splitbelow     = true           -- 默认新窗口下
vim.opt.fillchars      = { eob = ' ' }  -- 将行末波浪号替换为空格
vim.opt.ignorecase     = true           -- 忽略大小写
vim.opt.smartcase      = true           -- 智能匹配模糊搜索，依赖 ignorecase
vim.opt.cmdheight      = 0              -- 隐藏命令行，当用到时才显示
vim.opt.mouse:append("a")               -- 启用鼠标
vim.opt.clipboard = "unnamedplus"       -- 启用剪切板，需安装 wl-clipboard
vim.cmd('filetype plugin indent on')                -- 禁止换行自动注释-1
vim.cmd('autocmd FileType * set formatoptions-=ro') -- 禁止换行自动注释-2


vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.expandtab = false    -- 使用真正的制表符
    vim.opt_local.tabstop = 4          -- 制表符宽度为4
    vim.opt_local.shiftwidth = 4       -- 缩进宽度为4
    vim.opt_local.softtabstop = 4      -- 退格键删除4个空格
  end
})


--vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#232a2e', blend = 100 }) -- 非聚焦窗口（Not Current）背景色，hex+透明度（blend）
--vim.opt.winhighlight = 'Normal:Normal,NormalNC:NormalNC'



-- 快捷键
vim.keymap.set("i","\"\"","\"\"<left>")
vim.keymap.set("i","''","''<left>")
vim.keymap.set("i","()","()<left>")
vim.keymap.set("i","[]","[]<left>")
vim.keymap.set("i","{}","{}<left>")
vim.keymap.set("i","<>","<><left>")
vim.keymap.set("i","<A-k>","<up>")
vim.keymap.set("i","<A-j>","<down>")
vim.keymap.set("i","<A-h>","<left>")
vim.keymap.set("i","<A-l>","<right>")
vim.keymap.set({'n','i'},"<F1>","<nop>")             -- 屏蔽 F1 键，防止误操作
vim.keymap.set({'n','i'},"<F2>","<nop>")             -- 屏蔽 F2 键，防止误操作
vim.keymap.set("n","U","<nop>")                      -- 屏蔽 U 键，防止误操作
vim.keymap.set('n', 's', '<Nop>')                    -- 屏蔽 s 键，防止误操作
vim.keymap.set('n', 'S', '<Nop>')                    -- 屏蔽 S 键，防止误操作
vim.keymap.set("n", "<leader>h", "<C-w>h")           -- 切换到左边窗口
vim.keymap.set("n", "<leader>l", "<C-w>l")           -- 切换到右边窗口
vim.keymap.set("n", "<leader>j", "<C-w>j")           -- 切换到下方窗口
vim.keymap.set("n", "<leader>k", "<C-w>k")           -- 切换到上方窗口
vim.keymap.set("n", "<leader>n", "<cmd>noh<CR>")     -- 取消搜索高亮
vim.keymap.set("i", "<C-e>", "<ESC>A")               -- 编辑模式下，Ctrl-e 光标定位行尾
vim.keymap.set("i", "<C-a>", "<ESC>^i")              -- 编辑模式下，Ctrl-a 光标定位行首
vim.keymap.set("v", "<C-c>", "\"+y")                 -- 复制
vim.keymap.set("i", "<C-v>", "<ESC>\"+pa")           -- 粘贴
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>')       -- 关闭当前窗口
vim.keymap.set('n', '<A-q>', '<cmd>q<CR>')           -- 关闭当前窗口
vim.keymap.set('n', '<leader>|', '<cmd>vsp<CR>')     -- 左右分屏
vim.keymap.set('n', '<leader>_', '<cmd>sp<CR>')      -- 上下分屏
vim.keymap.set('n', '<A-\\>', '<Cmd>vsp<CR>')        -- 左右分屏
vim.keymap.set('n', '<A-->', '<Cmd>sp<CR>')          -- 上下分屏
vim.keymap.set('n', '<leader>x', '<C-w>x')           -- 交换窗口





-- 按下 ESC 键时切换 fcitx 为英文输入法
function fcitx() 
	if vim.env.TERM ~= "linux" then
		os.execute("fcitx5-remote -c &")
	end
end
vim.keymap.set({'i','n'}, "<ESC>", "<ESC><cmd>lua fcitx()<CR>")




-- 使用 # 搜索时不自动跳转
vim.keymap.set("n", "#", function()
	vim.fn.setreg("/", vim.fn.expand("<cword>"))
	vim.cmd("set hlsearch")
end)



-- 在终端中打开当前文件路径
function OpenInTerminal()
    local current_file = vim.fn.expand("%:p:h")
	local current_path = vim.fn.shellescape(current_file)
    --os.execute("foot --title=floating-terminal --working-directory " .. current_path .. " &>/dev/null &")
    os.execute("swaymsg splitv && foot -D " .. current_path .. " &>/dev/null && swaymsg split none &")
end
vim.keymap.set({'n', 'i'}, '<A-t>', OpenInTerminal)




vim.api.nvim_create_user_command(
	"Itable",
	function(args)
		local custom_text = {
			"<div class=\"table-container\"> ",
			"",
			"|||",
			"|:--|:--|",
			"|||",
			"",
			"</div>"
		}
		vim.api.nvim_put(custom_text, "c", true, true)
	end,
	{nargs = 0}
)
