tags: #student
title: Project ideas
description: For intership and thesis
maturity: 🌿

Student project ideas
=====================

Secure boot technológiák vizsgálata, és szoftverintegritás biztosítása beágyazott Linux rendszereken
----------------------------------------------------------------------------------------------------

Modern ARM alapú mikroprocesszoros rendszerekben (Cortex-A sorozat) az
üzleti értéket hordozó alkalmazás elindításáig számtalan egyéb szoftver
hívódik meg, amely inicializálja a hardvert, távmenedzsment funkciókat
éleszt fel stb. Az üzemeltetés során az illetéktelen behatolás két fő
veszélyt rejthet:

A módosított szoftver nem kívánt módon viselkedik a rendszerben (pl.
meghamisítja a mérési adatokat), A rendszerből adatok és IP szivároghat.
Ahhoz, hogy a veszélyeket elkerülhessük, szükséges a szoftverláncban egy
megbízhatósági láncot (“chain of trust”) kialakítani, azaz a következő
szoftver csak akkor léphessen működésbe, ha annak eredetiségéről
kétséget kizárólag megbizonyosodtunk.

Az evopro Innovation által használt processzorok egy részében olyan
szoftverláncot alkalmazunk, amelyek képesek lehetnek a következő
komponens (ROM loader -\> u-boot, u-boot-\>linux, linux-\>linux), vagy
akár önmaguk ellenőrzésére (dm-verity).

Feladat:

-   Ismerkedjen meg a következő technológiákkal és komponensekkel:
    u-boot FIT image / kernel aláírás és verifikáció / kernel titkosítás
    Linux dm alrendszer, ezen belül a dm-verity háttértárellenőrző layer
    Freescale code signing tools i.MX6 rendszereken
-   Valósítsa meg a kód dekriptálását validációját
-   Integrálja az evopro build rendszerébe

Kapcsolódó készségek és ismeretek:

-   Szoftverfejlesztés C és C++ nyelven
-   Linux ismeretek
-   Valós-idejű szoftverfejlesztés

[link]

Secure OS és secure storage technológiák vizsgálata és implementációja ARM processzoron
---------------------------------------------------------------------------------------

Modern ARM alapú mikroprocesszoros rendszerekben (Cortex-A sorozat) az
üzleti értéket hordozó alkalmazás elindításáig számtalan egyéb szoftver
hívódik meg, amely inicializálja a hardvert, távmenedzsment funkciókat
éleszt fel stb. Az üzemeltetés során az illetéktelen behatolás két fő
veszélyt rejthet:

A módosított szoftver nem kívánt módon viselkedik a rendszerben (pl.
meghamisítja a mérési adatokat), A rendszerből adatok és IP szivároghat.
Ahhoz, hogy a veszélyeket elkerülhessük, szükséges a szoftverláncban egy
megbízhatósági láncot (“chain of trust”) kialakítani, azaz a következő
szoftver csak akkor léphessen működésbe, ha annak eredetiségéről
kétséget kizárólag megbizonyosodtunk.

A vizsgálathoz szükséges adatok kezelése egy olyan komponens
segítségével valósítható meg, amely teljesen függetlenül él a normál
szoftvereinktől, és azok nem befolyásolhatják a működését. Az ARM
Trustzone megoldása szolgáltatja az ezt megvalósító CPU egységeket,
melyekhez létezik referencia OS implementáció Open-TEE néven.

Feladat:

Trustzone és Open-TEE funkciók felélesztése Freescale i.MX6 processzoron
Vizsgálja meg, hogy ez hogyan integrálható a normál OS-hez (Linux),
például rendszerintegritás figyelése vagy kriptográfiai adatok kezelése
céljából. Készítsen egy teszt implementációt, mely a minimális
funkcionalitás után integrálható az evopro saját build rendszerébe.
Kapcsolódó készségek és ismeretek:

Szoftverfejlesztés C és C++ nyelven Linux ismeretek Valós-idejű
szoftverfejlesztés

[link][1]

Távoli diagnosztikai alkalmazás fejlesztése i.MX6 alapú hardver családhoz
-------------------------------------------------------------------------

A hallgató feladata egy beágyazott Linux operációs rendszer fölött
dedikált alkalmazáscsomagot futtató eszköz felhő intergációját és távoli
menedzsmentjét támogató middleware fejlesztése. A middleware funkciói
között szerepel az eszköz távoli elérésének támogatása, az automatikus
firmware frissítés, a hálózat konfigurációja (pl. Wifi végpont SSID és
jelszó), illetve a futó alkalmazással való kétirányú (D2C és C2D)
kommunikáció. A feljesztés során törekedni kell az ilyenkor szokásosan
elvárt követelményeknek való megfelelésnek (egyszerűség, modularitás,
karbantarthatóság, bővíthetőség). A kész szoftvert ezek után illeszteni
kell az operációs rendszer fordítását végző környezetbe (buildroot). A
munka a teszteléssel és a kapcsolódó dokumentáció elkészítésével zárul.

Kamera illesztése i.MX6 alapú hardver családhoz
-----------------------------------------------

Napjainkban a kamera rendszerek alkalmazása és a gépi látás
elengedhetetlenné vált a modern ipari alkalmazásokban. A hallgató
feladata, hogy megismerje a kamera illesztés lehetőségeit az Evopro
Innovation által használt i.mx6 alapú beágyazott számítógépeken. Ez
magában foglalja a lehetséges kamera interface-k összehasonlítását
(MIPI-CSI, USB, Ethernet), a driver és a userspace szoftverek
integrálását (gstreamer) végül a rendszer működését pedig egy egyszerű
képfeldolgozó alkalmazással demonstrálja. Fontos szempont a munka során,
hogy a rendszer képes legyen a jövőben deep learning alkalmazások
futtatására. Ehhez jelenleg az i.mx6 Vivante GPU-ja, későbbi i.mx
szériákban pedig dedikált Neural Processing Unit tud hardveres
gyorsítóként szolgálni.RISC-V processzor alkalmazása Linux alapú
beágyazott rendszerekben - (open standard isa, open source hardware)

Yocto BSP layer készítése i.MX6 alapú hardver családhoz
-------------------------------------------------------

a yocto projekt az egyik legelterjedtebb keretrendszer beágyazott linux
disztribúciók összeállításához és fordításához. ma már számos félvezető
és sbc gyártó kizárólag yocto-hoz illeszkedő konfigurációs csomagokban
(layer-ekben) biztosít hivatalos szoftvertámogatást a termékeihez. A
hallgató feladata, hogy az Evopro Innovation egy egyedi tervezésű, NXP
i.MX6 processzor alapú, beágyazott számítógépéhez készítsen Yocto
réteget. A layer legyen felkészítve a hardver család eltérő
konfigurációjú tagjainak későbbi támogatására, valamint az ezekhez
tartozó egyedi szoftverkonfigurációk tárolására is. Az említett eszközök
leggyakrabban hálózatba kapcsolt beágyazott rendszerekben kerülnek
felhasználásra így a szoftvertámogatás legfontosabb eleme a szerver
oldali integráció. A legismertebb felhőszolgáltatók ma már kész platform
szolgáltatásokat (PaaS) nyújtanak ehhez. A hallgató feladatának emiatt
része egy olyan disztribúció készítése is, amely megvalósítja az Evopro
által alkalmazott Azure IoT Edge platformhoz való illesztést is.

Azure IoT Edge alkalmazás készítése i.MX6 alapú beágyazott számítógépre
-----------------------------------------------------------------------

Hálózatba kapcsolt beágyazott rendszerek elosztott számítási
architektúrájának fontos eleme az adatok keletkezési helyénél, illetve
annak határán történő feldolgozás (edge computing). Hagyományos
beágyazott rendszerek esetében az adatok gyakran csak összegyűjtésre
kerülnek, majd egy távoli adatközpontban kerülnek feldolgozásra. Edge
computing segítségével a keletkezési helyen történő feldolgozással
sávszélességet lehet spórolni, átviteli és későbbi tárolási költségeket
csökkenteni, valamint lehetőség van a gyors helyszíni beavatkozásra. Az
architektúra egyik kulcs eleme az adatokat feldolgozó alkalmazások
terjesztése (ez gyakran Linux konténerek segítségével történik) és az
eszközök tömeges konfigurálása. Erre ma több felhő szolgáltatónak kínál
megoldást az egyik legismertebb ezek közül az Azure IoT Edge a
Microsoft-tól. A hallgató feladata, hogy példa alkalmazást készítsen
i.MX6 fejlesztőkártyához, amely adatokat gyűjt és feldolgoz CAN és RS485
buszokról. A Linux container-be csomagolt alkalmazás és a hozzá tartozó
konfiguráció automatizáltan kerül telepítésre egyszerre több eszközre
Azure IoT Edge keretrendszeren keresztül. A szerver oldali illesztés
fontos része az adatok további feldolgozása, megjelenítése és tárolása,
ezért a hallgató további feladata, hogy a beágyazott rendszerben
összegyűjtött adat útjának ezen a lépéseit is bemutassa az Azure
platformon.

Gépi látás és deep learning alkalmazása gyártási folyamat minőségellenőrzésére
------------------------------------------------------------------------------

A minőségellenőrzési rendszerek lehetővé teszik a gyártással foglalkozó
cégek számára, hogy kiküszöböljék a termékgyártási folyamatok során
keletkező hibákat. A már meglévő tesztrendszerekből származó
hibaadatokkal és főképp a hibás termékekből származó adatokkal tovább
fejleszhetőek a termékgyártási folyamatok gépi tanulás segítségével. A
hallgató feladata egy kamerát felhasználó minőségellenőrző rendszer
prototípusának fejlesztése amellyel cserép gyártás során felmerülő
tipikus hibák ismerhetőek fel. A készült képeket az evopro Innovation
által használt i.mx6 alapú beágyazott számítógépen futtatott modellel
értékelje ki, amelynek célja a hibás termék felismerése és a jellegzetes
hiba típus meghatározása.

Intelligens IoT peremhálózat kiépítése felhő alapokon
-----------------------------------------------------

Ma a hálózatba kapcsolt beágyazott rendszerek egyik aktuális fejlesztési
iránya az edge computing: egyes számítási feladatok peremhálózatra való
áthelyezésével az eszközök kevesebbet kommunikálnak a felhővel így
gyorsabban reagálnak a helyi változásokra. Ehhez kapcsolódó kihívás az
üzleti logika beágyazott eszközökre való kitelepítése és a dinamikus
újrakonfigurálás, emiatt az ismert szerver oldali és cloud megoldások
(Linux container-ek, Function as a Service platformok) folyamatosan
kerülnek bevezetésre beágyazott rendszerekben.

A legnagyobb felhő szolgáltatók saját rendszerei (AWS IoT Greengrass,
Azure IoT Edge) kompakt megoldást kínálnak ezek építésére. A hallgató
feladata:

-   AWS IoT Greengrass és Azure IoT Edge szolgáltatások megismerése és
    összehasonlítása
-   K3s Lightweight Kubernetes megismerése
-   NXP i.MX6 alapú fejlesztőkártya csatlakoztatása ezekhez a
    rendszerekhez
-   Működés bemutatása egy példaalkalmazás segítségével

Elsajátítható készségek és ismeretek:

-   Beágyazott Linux ismeretek
-   Linux container ismeretek
-   Szoftverfejlesztés C és Python nyelven

[Link][2]

2022 Title ideas
----------------

-   RISC-V processzor alkalmazása Linux alapú beágyazott rendszerekben

> open standard isa, open source hardware

-   ARM Ethos neurális gyorsító vizsgálata gépi látás alkalmazásokban

> nxp imx9

-   Hardver integrált security megoldások vizsgálata ARM processzorokon

> eitg, nxp secure enclave, arm trustzone

-   Távoli firmware frissítés megvalósítása nyílt forráskódú Linux
    rendszerekben

> on-prem firmware update, open source

-   Debian alapú beágyazott Linux fordítása és BSP integrálás ELBE
    keretrendszerrel

> debian package feed based embedded systems, security, firmware update,
> edge

Debian alapú beágyazott Linux fordítása és BSP integrálás ELBE keretrendszerrel
-------------------------------------------------------------------------------

Napjainkban több nyílt forráskódú keretrendszert is használhatunk saját
Linux disztribúció készítésére. Ezek közül a legismertebb a Yocto és a
Buildroot, viszont mindkettő esetében saját magunknak kell gondoskodunk
az összes felhasznált szoftver csomag fordításáról vagy
keresztfordításáról. Ebből következően minden csomag esetleges
biztonsági frissítése is a fejlesztő feladata, ami sok üzemeltetési
munkát jelent. Erre nyújt megoldást az ELBE keretrendszer ahol
publikusan elérhető más disztribúciók (Debian, Ubuntu) által használt
csomagokat újrahasználhatunk és azok segítségével készíthetünk egyedi
beágyazott Linux rendszert. A hallgató feladata, hogy készítsen az
Evopro Innovation egy egyedi tervezésű ARM alapú beágyazott
számítógépéhez egy Debian alapú Linux disztribúciót ELBE keretrendszer
segítségével.

-   Ismerkedjen meg a következő technológiákkal és komponensekkel: ELBE,
    Debian package feed, .deb packaging
-   Készítsen bootolható lemezképet egy ARM alapú számítógéphez

Kapcsolódó készségek és ismeretek:

-   Szoftverfejlesztés C és C++ nyelven
-   Linux ismeretek

  [Student project ideas]: #student-project-ideas
  [Secure boot technológiák vizsgálata, és szoftverintegritás biztosítása beágyazott Linux rendszereken]:
    #secure-boot-technológiák-vizsgálata-és-szoftverintegritás-biztosítása-beágyazott-linux-rendszereken
  [Secure OS és secure storage technológiák vizsgálata és implementációja ARM processzoron]:
    #secure-os-és-secure-storage-technológiák-vizsgálata-és-implementációja-arm-processzoron
  [Távoli diagnosztikai alkalmazás fejlesztése i.MX6 alapú hardver családhoz]:
    #távoli-diagnosztikai-alkalmazás-fejlesztése-imx6-alapú-hardver-családhoz
  [Kamera illesztése i.MX6 alapú hardver családhoz]: #kamera-illesztése-imx6-alapú-hardver-családhoz
  [Yocto BSP layer készítése i.MX6 alapú hardver családhoz]: #yocto-bsp-layer-készítése-imx6-alapú-hardver-családhoz
  [Azure IoT Edge alkalmazás készítése i.MX6 alapú beágyazott számítógépre]:
    #azure-iot-edge-alkalmazás-készítése-imx6-alapú-beágyazott-számítógépre
  [Gépi látás és deep learning alkalmazása gyártási folyamat minőségellenőrzésére]:
    #gépi-látás-és-deep-learning-alkalmazása-gyártási-folyamat-minőségellenőrzésére
  [Intelligens IoT peremhálózat kiépítése felhő alapokon]: #intelligens-iot-peremhálózat-kiépítése-felhő-alapokon
  [2022 Title ideas]: #2022-title-ideas
  [Debian alapú beágyazott Linux fordítása és BSP integrálás ELBE keretrendszerrel]:
    #debian-alapú-beágyazott-linux-fordítása-és-bsp-integrálás-elbe-keretrendszerrel
  [link]: http://www.mit.bme.hu/oktatas/temakiirasok/2016/secure-boot-technologiak-vizsgalata-es-szoftverintegritas-biztositasa
  [1]: http://www.mit.bme.hu/oktatas/temakiirasok/2016/secure-os-es-secure-storage-technologiak-vizsgalata-es-implementacioja-arm
  [2]: http://www.mit.bme.hu/oktatas/temakiirasok/2019/intelligens-iot-peremhalozat-kiepitese-felho-alapokon-evopro
