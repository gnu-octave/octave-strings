OCTAVE ?= octave
MKOCTFILE ?= mkoctfile -Wall

PCRE_SWITCHES := $(shell $(OCTAVE) \
	--no-gui --no-init-file --no-site-file --silent \
	--eval 'disp (octave_config_info ("PCRE_LIBS"));' \
	--eval 'disp (octave_config_info ("PCRE_CPPFLAGS"));' \
	)

pcregexp.oct: %.oct: %.cc
	$(MKOCTFILE) $(PCRE_SWITCHES) -o $@ $<

clean:
	rm -f *.o octave-core core *.oct *~

