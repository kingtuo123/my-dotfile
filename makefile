origins += /etc/udev/rules.d/*.rules
#origins += /etc/fstab
origins += /etc/portage/make.conf
origins += /etc/portage/repos.conf
origins += /etc/portage/package.use
origins += /usr/src/linux/.config
origins += ~/.bashrc
origins += ~/.bash_profile
origins += ~/Container
origins += ~/Scripts
origins += ~/.config/alacritty
origins += ~/.config/foot
origins += ~/.config/i3blocks
origins += ~/.config/mako
origins += ~/.config/nvim
origins += ~/.config/rofi
origins += ~/.config/sway
origins += ~/.config/swayimg




ignores := ! -name "*.deb"
ignores += ! -name "*.tar.*"
ignores += ! -name "lazy-lock.json"
ignores += ! -path "*/.git/*"
ignores += ! -path "*/homedir/*"
ignores += ! -path "*/distdir/*"




PWD     := $(shell pwd)
origins := $(shell find $(origins) $(ignores) -type f | xargs realpath)
backups := $(addprefix $(PWD),$(origins))
removed := $(filter-out $(origins),$(subst ./,/,$(shell find . -mindepth 2 $(ignores) -type f)))




all: $(backups) $(removed)
	@echo ""


$(backups): $(PWD)%: %
	@cp --parents $< .
	@echo -e "\e[32m+ .$<\e[0m"


$(removed): %: $(PWD)%
	@echo -e "\e[31m? .$@\e[0m"


git:
	git add -A
	git commit -m "update"
	git push
