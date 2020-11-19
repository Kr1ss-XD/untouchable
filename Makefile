PRJNAME        = untouchable
BUGADDR        = Kr1ss X <kr1ss.x@yandex.com>

DESTDIR       ?=

ifeq ($(LOCAL), true)
PREFIX        ?= /usr/local
else
PREFIX        ?= /usr
endif
ifdef DIST
	INITCPIODIR ?= $(PREFIX)/lib/initcpio
else
	INITCPIODIR ?= $(SYSCONFDIR)/initcpio
endif

SYSCONFDIR    ?= /etc
MKINITCONF    ?= $(SYSCONFDIR)/mkinitcpio.conf
MKINITTDIR    ?= $(SYSCONFDIR)/mkinitcpio.d

INSTALL_EXE   ?= $(shell which install) -vDm755 -t
INSTALL_DATA  ?= $(shell which install) -vDm644 -t
RM            ?= $(shell which rm) -vf
RMDIR         ?= $(shell which rmdir) -vp --ignore-fail-on-non-empty


.PHONY: install
install:
	@echo 'Installing the initcpio hook ...'; \
	for folder in hooks install; do \
		$(INSTALL_DATA) $(DESTDIR)$(INITCPIODIR)/$$folder/ $$folder/$(PRJNAME); \
	done


.PHONY: uninstall
uninstall:
	@echo 'Removing the initcpio hook ...'; \
	for folder in hooks install; do \
		$(RM) $(DESTDIR)$(INITCPIODIR)/$$folder/$(PRJNAME); \
		$(RMDIR) $(DESTDIR)$(INITCPIODIR)/$$folder | head -n -1; \
	done


# vim: ts=2 sw=2 noet ft=make:
