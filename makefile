SHELL=/usr/bin/bash




origins := /etc/udev/rules.d/*.rules
origins += /etc/fstab
origins += /etc/local.d/*.start
origins += /etc/portage/make.conf
origins += /etc/portage/repos.conf
origins += /etc/portage/package.use/list.use
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
origins += ~/.config/repo




ignores := ! -name '*.deb'
ignores += ! -name '*.tar.*'
ignores += ! -name 'lazy-lock.json'
ignores += ! -path '*/.git/*'
ignores += ! -path '*/homedir/*'
ignores += ! -path '*/distdir/*'
ignores += ! -path '*/repo/*/files/*'




origins := $(shell find $(origins) $(ignores) -type f -print0 | xargs -0 -r realpath)
backups := $(addprefix $(CURDIR),$(origins))
removed := $(filter-out $(origins),$(patsubst ./%,/%,$(shell find . -mindepth 2 $(ignores) -type f)))




all: $(backups) $(removed)
	@if [[ -n "$$(git status -s)" ]];then echo ""; git status -s; echo ""; fi


$(backups): $(CURDIR)%: %
	@cp --parents $< .
	@echo -e "\e[32m + .$<\e[0m"


$(removed): %: $(CURDIR)%
	@echo -e "\e[31m ? .$@\e[0m"


git:
	@git add -A
	@git diff --staged --quiet || git commit -m "backup: $$(date +'%F %T')"
	@git push
