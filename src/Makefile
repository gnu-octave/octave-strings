OCTAVE ?= octave
MKOCTFILE ?= mkoctfile -Wall

PCRE_LIBS := $(shell $(OCTAVE) --no-gui --no-init-file --no-site-file --silent \
                               --eval 'disp (octave_config_info ("PCRE_LIBS"))')

pcregexp.oct: %.oct: %.cc
	$(MKOCTFILE) $(PCRE_LIBS) -o $@ $<

clean:
	rm -f *.o octave-core core *.oct *~

