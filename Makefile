#!make
SHELL ?= /bin/bash
ifdef ComSpec
	PATHSEP2 := \\
else
	PATHSEP2 := /
endif
PATHSEP := $(strip $(PATHSEP2))

LATN := \
	NotoSans-Black.ttf \
	NotoSans-BlackItalic.ttf \
	NotoSans-Bold.ttf \
	NotoSans-BoldItalic.ttf \
	NotoSans-ExtraBold.ttf \
	NotoSans-ExtraBoldItalic.ttf \
	NotoSans-ExtraLight.ttf \
	NotoSans-ExtraLightItalic.ttf \
	NotoSans-Italic.ttf \
	NotoSans-Light.ttf \
	NotoSans-LightItalic.ttf \
	NotoSans-Medium.ttf \
	NotoSans-MediumItalic.ttf \
	NotoSans-Regular.ttf \
	NotoSans-SemiBold.ttf \
	NotoSans-SemiBoldItalic.ttf \
	NotoSans-Thin.ttf \
	NotoSans-ThinItalic.ttf \
	NotoSerif-Black.ttf \
	NotoSerif-BlackItalic.ttf \
	NotoSerif-Bold.ttf \
	NotoSerif-BoldItalic.ttf \
	NotoSerif-ExtraBold.ttf \
	NotoSerif-ExtraBoldItalic.ttf \
	NotoSerif-ExtraLight.ttf \
	NotoSerif-ExtraLightItalic.ttf \
	NotoSerif-Italic.ttf \
	NotoSerif-Light.ttf \
	NotoSerif-LightItalic.ttf \
	NotoSerif-Medium.ttf \
	NotoSerif-MediumItalic.ttf \
	NotoSerif-Regular.ttf \
	NotoSerif-SemiBold.ttf \
	NotoSerif-SemiBoldItalic.ttf \
	NotoSerif-Thin.ttf \
	NotoSerif-ThinItalic.ttf \
	NotoSansMono-Black.ttf \
	NotoSansMono-Bold.ttf \
	NotoSansMono-ExtraBold.ttf \
	NotoSansMono-ExtraLight.ttf \
	NotoSansMono-Light.ttf \
	NotoSansMono-Medium.ttf \
	NotoSansMono-Regular.ttf \
	NotoSansMono-SemiBold.ttf \
	NotoSansMono-Thin.ttf \
	NotoColorEmoji.ttf

CJK := \
	NotoSansCJK-VF.ttf.ttc \
	NotoSerifCJK-VF.ttf.ttc \
	NotoSansMonoCJKjp-VF.ttf

FONTS_LATN := $(addprefix fonts-latn/,$(LATN))
FONTS_CJK := $(addprefix fonts-cjk/,$(CJK))

all: noto-fonts-latn.zip noto-fonts-cjk.zip

test:

clean:
	rm -rf noto-fonts-*.zip fonts-latn fonts-cjk tmp

distclean: clean
	rm -rf .archive

noto-fonts-latn.zip: $(FONTS_LATN)
	zip -9 -r $@ fonts-latn

noto-fonts-cjk.zip: $(FONTS_CJK)
	zip -9 -r $@ fonts-cjk

fonts-%:
	mkdir -p $(subst /,$(PATHSEP),$@)

fonts-latn/NotoSans-%: | fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSans/$(notdir $@)

fonts-latn/NotoSansMono-%: | fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSansMono/$(notdir $@)

fonts-latn/NotoSerif-%: | fonts-latn
	curl -ssL -o $@	https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSerif/$(notdir $@)

fonts-latn/NotoColorEmoji.ttf: fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf

fonts-cjk/NotoSansCJK-VF.ttf.ttc fonts-cjk/NotoSansMonoCJKjp-VF.ttf: .archive/noto-sans-cjk.zip | fonts-cjk
	mkdir -p tmp/noto-sans-cjk; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-sans-cjk ; \
	cp tmp/noto-sans-cjk/$(notdir $@) $@

fonts-cjk/NotoSerifCJK-VF.ttf.ttc: .archive/noto-serif-cjk.zip | fonts-cjk
	mkdir -p tmp/noto-serif-cjk; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-serif-cjk ; \
	cp tmp/noto-serif-cjk/$(notdir $@) $@

tmp:
	mkdir -p $@

.archive:
	mkdir -p $@

.archive/noto-sans-cjk.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/02_NotoSansCJK-TTF-VF.zip

.archive/noto-serif-cjk.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Serif2.001/03_NotoSerifCJK-TTF-VF.zip

# version:
# 	echo "${JAR_VERSION}"

.PHONY: all clean distclean test
