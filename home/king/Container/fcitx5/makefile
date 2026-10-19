PN  := fcitx5
PV  := latest


USE := default  home  wayland  dbus  fonts
OPT := --network none


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --network host .


config:
	docker exec -it $(PN) fcitx5-configtool


# 白霜拼音
install-pinyin-baishuang:
	mkdir -p ./homedir/.local/share/fcitx5
	git clone --depth 1 https://github.com/gaboolic/rime-frost ./homedir/.local/share/fcitx5/rime


# 薄荷拼音
install-pinyin-mint:
	mkdir -p ./homedir/.local/share/fcitx5
	git clone --depth 1 https://github.com/Mintimate/oh-my-rime ./homedir/.local/share/fcitx5/rime


# 万象拼音
install-pinyin-wanxiang-base:
	mkdir -p ./homedir/.local/share/fcitx5
	-git clone --depth 1 -b wanxiang-base https://github.com/amzxyz/rime-wanxiang ./homedir/.local/share/fcitx5/rime
	curl -L https://cnb.cool/amzxyz/rime-wanxiang/-/releases/download/model/wanxiang-lts-zh-hans.gram -C - -o ./homedir/.local/share/fcitx5/rime/wanxiang-lts-zh-hans.gram


install-theme-everforest:
	mkdir -p ./homedir/.local/share/fcitx5/themes
	git clone --depth 1 https://github.com/RickyJian/fcitx5-everforest ./homedir/.local/share/fcitx5/themes


install-theme-ori:
	mkdir -p ./homedir/.local/share/fcitx5/themes
	git clone --depth 1 https://github.com/Reverier-Xu/Ori-fcitx5 ./homedir/.local/share/fcitx5/themes


install-theme-mellow:
	mkdir -p ./homedir/.local/share/fcitx5/themes
	git clone --depth 1 https://github.com/sanweiya/fcitx5-mellow-themes ./homedir/.local/share/fcitx5/themes


rm-rime:
	rm -rf ./homedir/.local/share/fcitx5/rime


rm-theme:
	rm -rf ./homedir/.local/share/fcitx5/themes


include ../makefile
