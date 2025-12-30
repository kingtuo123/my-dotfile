PWD  := $(shell pwd)
USER := $(shell whoami)


origins += /etc/udev/rules.d/*.rules
origins += ~/Container
origins += ~/.bashrc
origins += ~/.bash_profile
origins += ~/.config/sway
origins += ~/Desktop/jubao


ignores := ! -name "*.deb"
ignores += ! -name "*.tar.*"
ignores += ! -path "*/.git/*"
ignores += ! -path "*/homedir/*"


origins := $(shell find $(origins) $(ignores) -type f | xargs realpath)
backups := $(addprefix $(PWD),$(origins))
removed := $(filter-out $(origins),$(subst ./,/,$(shell find . -mindepth 2 $(ignores) -type f)))


all: $(backups) $(removed)
	@echo ""

#@cp --parents $< .

$(backups): $(PWD)%: %
	@echo -e "\e[32m+ .$<\e[0m"


$(removed): %: $(PWD)%
	@echo -e "\e[31m? .$@\e[0m"


debug:
	@echo origins = $(origins)
	@echo backups = $(backups)
	@echo removed = $(removed)
