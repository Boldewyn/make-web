#
# Image optimization
#

IMAGES_OPTIMIZE_PNG ?= optipng -o7
IMAGES_OPTIMIZE_JPEG ?= jpegoptim --strip-all
IMAGES_OPTIMIZE_GIF ?= gifsicle -i --batch
IMAGES_SRC ?= $(shell find . -type f \
                \( -name \*.png -or -name \*.gif -or -name \*.jpg \) )

.PHONY: images

images: $(IMAGES_SRC)

$(IMAGES_SRC):
ifeq ($(suffix $<), .png)
	$(IMAGES_OPTIMIZE_PNG) "$<"
else ifeq ($(suffix $<), .jpg)
	$(IMAGES_OPTIMIZE_JPEG) "$<"
else ifeq ($(suffix $<), .gif)
	$(IMAGES_OPTIMIZE_GIF) "$<"
else
	$(warning Unsupported file type: $(suffix $<))
endif
