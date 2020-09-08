VERSION := 20.10
RELEASE := Groovy
ARCH_BUILD :=$(shell uname -m)

all: build

build:
        ifeq (${ARCH_BUILD}, x86_64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
        else ifeq (${ARCH_BUILD}, x86_32)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
        else ifeq (${ARCH_BUILD}, aarch64)
		sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version-arm.in > files/desktop-version
        endif

install:
	mkdir -p ${DESTDIR}/etc
	mkdir -p ${DESTDIR}/usr/share/i18n
	mkdir -p ${DESTDIR}/usr/share/distro-info
	mkdir -p ${DESTDIR}/usr/share/python-apt/templates
	mkdir -p ${DESTDIR}/usr/share/deepin
	mkdir -p ${DESTDIR}/usr/share/ubuntudde
	install -Dm644 files/i18n_dependent.json  ${DESTDIR}/usr/share/i18n/i18n_dependent.json
	install -Dm644 files/language_info.json  ${DESTDIR}/usr/share/i18n/language_info.json
	install -Dm644 files/desktop-version ${DESTDIR}/usr/lib/deepin/desktop-version
	#install -Dm644 files/os-license ${DESTDIR}/var/uos/os-license
	#install -Dm644 files/os-version ${DESTDIR}/etc/os-version
	#install -Dm644 files/lsb-release     ${DESTDIR}/etc/lsb-release
	#install -Dm644 files/deepin-logo.png ${DESTDIR}/usr/share/plymouth/deepin-logo.png
	#install -Dm644 files/desktop.jpg     ${DESTDIR}/usr/share/backgrounds/deepin/desktop.jpg
	#install -Dm644 files/uos_logo.svg     ${DESTDIR}/usr/share/deepin/uos_logo.svg
	#install -Dm644 files/dde-desktop-watermask.json     ${DESTDIR}/usr/share/deepin/dde-desktop-watermask.json
	[ -e files/systemd.conf ] && install -Dm644 files/systemd.conf ${DESTDIR}/etc/systemd/system.conf.d/deepin-base.conf
	[ -e files/logind.conf ] && install -Dm644 files/logind.conf ${DESTDIR}/etc/systemd/logind.conf.d/deepin-base.conf
	
clean:
	rm -f files/desktop-version
	rm -f files/lsb-release
