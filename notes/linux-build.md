Embedded Linux build systems
============================

Buildroot
---------

-   use an external layer, don't forget to set the env variable before
    make my\_defconfig
-   build images with genimage and sign in post-image.sh
-   generate configs image with in-fakeroot.sh (why? I don't remember)
-   create patches with quilt
-   can have multiple rootfs\_overlays, use a common base for multiple
    boards

**override built-in package build steps in external.mk**

    # Strongswan TPM2 support
    #STRONGSWAN_CONF_OPTS += \
    #   --enable-tss-tss2=yes \
    #   --enable-tpm=yes \

    #STRONGSWAN_DEPENDENCIES += tpm2-tss tpm2-abrmd

    # Start TPM2 abrmd before Strongswan
    define TPM2_ABRMD_INSTALL_INIT_SYSV
        $(INSTALL) -D -m 0755 $(TPM2_ABRMD_PKGDIR)/S80tpm2-abrmd \
            $(TARGET_DIR)/etc/init.d/S38tpm2-abrmd
    endef

Yocto
-----

TODO: Document custom layer

[Tips from kc8apf](https://www.kc8apf.net/archives)
