DESTDIR ?=
PREFIX ?= /usr

FRIDA := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Features ordered by binary footprint, from largest to smallest
FRIDA_V8 ?= no
FRIDA_CONNECTIVITY ?= no
FRIDA_DATABASE ?= no
FRIDA_JAVA_BRIDGE ?= no
FRIDA_OBJC_BRIDGE ?= no
FRIDA_SWIFT_BRIDGE ?= no

FRIDA_AGENT_EMULATED ?= no

# Include jailbreak-specific integrations
FRIDA_JAILBREAK ?= no

FRIDA_ASAN ?= no

ifeq ($(FRIDA_ASAN), yes)
FRIDA_FLAGS_COMMON := -Doptimization=1 -Db_sanitize=address
FRIDA_FLAGS_BOTTLE := -Doptimization=1 -Db_sanitize=address
else
FRIDA_FLAGS_COMMON := -Doptimization=s -Db_ndebug=true --strip
FRIDA_FLAGS_BOTTLE := -Doptimization=s -Db_ndebug=true --strip
endif

FRIDA_MAPPER := -Dmapper=auto

XCODE11 ?= /Applications/Xcode-11.7.app

PYTHON ?= $(shell which python3)
PYTHON_VERSION := $(shell $(PYTHON) -c 'import sys; v = sys.version_info; print("{0}.{1}".format(v[0], v[1]))')
PYTHON_NAME ?= python$(PYTHON_VERSION)
PYTHON_PREFIX ?=
PYTHON_INCDIR ?=

PYTHON3 ?= python3

NODE ?= $(shell which node)
NODE_BIN_DIR := $(shell dirname $(NODE) 2>/dev/null)
NPM ?= $(NODE_BIN_DIR)/npm

MESON ?= $(PYTHON3) $(FRIDA)/releng/meson/meson.py

tests ?=
