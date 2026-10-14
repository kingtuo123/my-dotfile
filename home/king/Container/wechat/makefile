PN  := wechat
PV  := 4.1.13
URI := https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb


USE := default  home  wayland  dbus  audio  fonts
OPT := --network bridge


run: $(USE)
	docker run --rm  -d --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch:
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


include ../makefile
