MKOCTFILE = mkoctfile -Wall

PCRE_LIBS := $(shell  grep "\#define OCTAVE_CONF_PCRE_LIBS"  $(shell  $(MKOCTFILE) -p OCTINCLUDEDIR)/oct-conf.h | sed 's/^.*LIBS //;s/"//g'  )

all: pcregexp.oct

%.oct: %.cc
	$(MKOCTFILE) $<  -o $@ $(PCRE_LIBS)

clean:
	rm -f *.o octave-core core *.oct *~
