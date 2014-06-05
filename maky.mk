# MAKY -- v2.4
MAKYVERSION = 2.4
# Part of MySetup Project
# https://github.com/carrieje/mysetup
#####
# LICENCE
# Generic Makefile with easy customization
# Copyright (C) 2014 Jeremy Carrier
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


#####
# README
# To get some hints on how to use this makefile, run
# make help


#####
# BASIC CUSTOMIZATION
EXTENSION = cpp
COMPILER  = g++
PACKAGES  =
EXTRAINCL =
EXTRALIBS =

#####
# PLUMBING CUSTOMIZATION
MAINS   = main.$(EXTENSION)
CFLAGS  = -W -Wall -pedantic $(ALL_HDRS)
LDFLAGS = $(ALL_LIBS)


#####                         ####                         #####
# DO NOT CUSTOMIZE BELOW THIS LINE UNLESS YOU KNOW WHAT YOU DO #
#####                         ####                         #####


#####
# INTERNAL SETTINGS
ALL_HDRS = $(foreach pack, $(PACKAGES), $(shell echo `pkg-config --cflags $(pack)`)) $(EXTRAINCL)
ALL_LIBS = $(foreach pack, $(PACKAGES), `pkg-config --libs $(pack)`) $(EXTRALIBS)

EXT     = $(EXTENSION)
CC      = $(COMPILER)
ALLSRC  = $(wildcard *.$(EXT))
SRC     = $(filter-out $(MAINS),$(ALLSRC))
OBJ     = $(SRC:.$(EXT)=.o)

.SECONDEXPANSION:
.PHONY: all clean mrproper list pkgs-avail pkgs-version help

#####
# COMPILATION TARGETS
all: pkgs-avail $(MAINS:.$(EXT)=)

$(MAINS:.$(EXT)=): $(OBJ) $$(@).o
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.$(EXT)
	$(CC) -o $@ -c $< $(CFLAGS)

#####
# PHONY TARGETS
clean:
	rm -rf $(OBJ) $(MAINS:.$(EXT)=.o)

mrproper: clean
	rm -rf $(MAINS:.$(EXT)=)

list:
	@echo -e "Sources $(SRC)\nObjets  $(OBJ)\nMains   $(MAINS)"

pkgs-version:
	@for p in $(PACKAGES); do \
		echo -n "$$p : "; \
		pkg-config --modversion $$p; \
	done

pkgs-avail:
	@for p in $(PACKAGES); do \
		pkg-config --exists $$p; \
		if [ $$? -ne 0 ]; then \
			echo -en "\033[31m" > /dev/stderr; \
			echo -en "The package $$p does not exist" > /dev/stderr; \
			echo -e  "\033[0m" > /dev/stderr; \
		fi; \
	done

help:
	@echo "Maky version $(MAKYVERSION)"; \
	echo "Generic Makefile for all your projects (C, C++ and so...)"; \
	echo "Even multi-main ones."; \
	echo ""; \
	echo "COMPILATION TARGETS :"; \
	echo " * all          : check for packages availability and make all"; \
	echo "                  executables"; \
	echo " * EXECUTABLE   : name your main file without extension to"; \
	echo "                  compile only this executable"; \
	echo "INFORMATION TARGETS :"; \
	echo " * clean        : delete objects"; \
	echo " * mrproper     : delete objects and executables"; \
	echo " * list         : list all recognized files"; \
	echo " * pkgs-version : list all the packages along with their"; \
	echo "                  version number"; \
	echo " * pkgs-avail   : Check for pakages availability through"; \
	echo "                  pkg-config. No output if all of the packages exist."; \
	echo ""; \
	echo "SETTINGS :"; \
	echo "   To set Maky for your project, edit it, and fill the"; \
	echo "   BASIC CUSTOMIZATION section."; \
	echo "   You can go further in editing the PLUMBING CUSTOMIZATION"; \
	echo "   section. For instance by adding a file containing a main in"; \
	echo "   the MAINS list.";

