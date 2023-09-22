i.MX security
=============

Parsing x.509 in firmware code is [spoooky]. Calling code from a
previous boot stage is [scary]. But what other options do we have?

Slightly related topics:

-   using eFPGAs
-   distributed trust


Secure Boot HAB
---------------

i.mx8M still uses HAB, other imx8 variants use AHAB.

Commands remained the same:

-   burn some fuse
-   call `hab_image_auth`
-   check `hab_status`
-   if ok, burn more

How to automate:

-   Buildroot: diy scripts called by `post-image.sh`
-   Yocto: [meta-variscite-hab]

<!-- -->

    #!/usr/bin/env bash

    KEYS_PATH="${BINARIES_DIR}/../../../keys"

    # Code Signing tool is customized to load dek.bin from the env var KEYS_PATH
    export KEYS_PATH

    # Load template
    cp "$(dirname $0)/templates/u-boot.csf_template" "${BINARIES_DIR}/uboot.csf"

    # Fill out key location
    sed -i "s:KEY_LOCATION:${KEYS_PATH}:g" "${BINARIES_DIR}/uboot.csf"

    # Fill out image location
    sed -i "s:IMAGES:${BINARIES_DIR}:g" "${BINARIES_DIR}/uboot.csf"

    # Read u-boot.imx.log to check uboot size
    HAB_LINE=$(cat "${BINARIES_DIR}/../build/uboot-2018.05/u-boot.imx.log" | grep HAB)
    read -ra UBOOT_HAB <<< $HAB_LINE

    # Fill out DECRYPT_SIZE in CSF template - 0xc10 = IVT + DCD is the data we need to sign
    UBOOT_DECRYPT_SIZE=$( printf '%x\n' $(( ${UBOOT_HAB[4]} - 0xc10 )) )
    sed -i "s/DECRYPT_SIZE/${UBOOT_DECRYPT_SIZE}/g" "${BINARIES_DIR}/uboot.csf"

    # Fill out BLOB_LOCATION in CSF template
    BLOB_LOCATION=$( printf '%x\n' $(( 0x177ff400 + ${UBOOT_HAB[4]} + 0x1F00 )) )
    sed -i "s/BLOB_LOCATION/${BLOB_LOCATION}/g" "${BINARIES_DIR}/uboot.csf"

    # Backup uboot.imx, because CST modifies the file 
    cp "${BINARIES_DIR}/u-boot.imx" "${BINARIES_DIR}/u-boot.imx.back"

    ${HOST_DIR}/cst-2.3.2/cst_encrypt_custom --o "${BINARIES_DIR}/u-boot_csf.bin" --i "${BINARIES_DIR}/uboot.csf"

    objcopy -I binary -O binary --pad-to=0x1F00 --gap-fill=0x00 ${BINARIES_DIR}/u-boot_csf.bin ${BINARIES_DIR}/u-boot_csf.bin

    cat "${BINARIES_DIR}/u-boot.imx.back" "${BINARIES_DIR}/u-boot_csf.bin" > "${BINARIES_DIR}/u-boot-signed.imx" 

Patch code signing tool and load DEK key from custom path:

    diff --git a/cst-2.3.2/code/back_end/src/adapt_layer_openssl.c b/cst-2.3.2/code/back_end/src/adapt_layer_openssl.c
    index c0ed926..ba9a1f8 100755
    --- a/cst-2.3.2/code/back_end/src/adapt_layer_openssl.c
    +++ b/cst-2.3.2/code/back_end/src/adapt_layer_openssl.c
    @@ -719,9 +719,21 @@ int32_t generate_dek_key(uint8_t * key, int32_t len)
       /*  if (gen_random_bytes(key, len) != CAL_SUCCESS) {
             return CAL_CRYPTO_API_ERROR;
         } */
    +    char key_path[256];
    +    char* pPath;
    +    FILE* fp;

    -    FILE* fp= fopen("dek_pre.bin","rb");
    -
    +    pPath = getenv("KEYS_PATH");
    +    if (pPath !=NULL) strcpy(key_path, pPath);
    +    else {
    +	printf("KEYS_PATH variable not exists!\n");
    +	return CAL_CRYPTO_API_ERROR;
    +
    +    }
    +    strcat(key_path,"/dek.bin");
    +    printf("%s\n",key_path);
    +    fp = fopen(key_path,"rb");
    +
         if (!fp) return CAL_CRYPTO_API_ERROR;

         else {

Trusted Firmware
----------------

[https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html]

verify using secure boot eg. imx HAB - bl31.bin

NXP and PUF
-----------

[https://www.nxp.com/docs/en/application-note/AN12324.pdf]

  [spoooky]: https://blog.quarkslab.com/vulnerabilities-in-high-assurance-boot-of-nxp-imx-microprocessors.html
  [scary]: https://research.nccgroup.com/2022/10/03/shining-new-light-on-an-old-rom-vulnerability
  [meta-variscite-hab]: https://github.com/varigit/meta-variscite-hab
  [https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html]:
    https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html
  [https://www.nxp.com/docs/en/application-note/AN12324.pdf]: https://www.nxp.com/docs/en/application-note/AN12324.pdf
