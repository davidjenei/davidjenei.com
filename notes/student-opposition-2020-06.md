VARGA TAMÁS "LINUX PORTOLÁSA ZYNQ 7000 SOC-RE" CÍMŰ DIPLOMATERVÉNEK A BÍRÁLATA
==============================================================================

A Xilinx 2011-ben megjelent Zynq-7000 családja a számítási architektúrák
egy új formáját tette népszerűvé, amikor egyetlen lapkán ötvözte az ARM
mikroprocesszorok könnyű programozhatóságát és az FPGA-k flexibilitását.
A platformhoz számos támogatott operációs rendszert találhatunk: a valós
idejű OS-ek mellett több kereskedelmi forgalomban kapható vagy ingyenes
Linux disztribúció is elérhető. Linux alapú beágyazott rendszerek
alkalmazása során viszont felmerülhet az igény a testre szabásra, ennek
oka lehet például egyedi hardver komponens támogatása vagy saját
frissítési módszer megvalósítása, ilyen esetekben pedig a Linux alapú
rendszerek több alkotó részének (bootloader, device tree, kernel, root
fájlrendszer) összehangolt módosítása szükséges. A komponensek adott
hardver platformhoz való hangolását nevezzük portolási folyamatnak, ami
az egyik első lépése az ilyen rendszerek építésének.

A dolgozat a bevezetésben fogalom magyarázatokkal indít. Egy Linux alapú
beágyazott rendszer számos hardver és szoftver komponensből épül fel,
ezeket valóban hasznos áttekinteni, illetve olyan népszerű fogalmakat
definiálni, mint a firmware, aminek több értelmezése is lehetséges. A
fogalmak adott témakör szerinti sorba rendezése és bevezetése (pl. PHY
és Ethernet egymás után rendezése) segíthetné a megértést, illetve
néhány magyarázó mondat, hogy miért pont ezeket a fogalmakat tárgyaljuk.

A második fejezetben bemutatásra kerülnek az alkalmazott
fejlesztőkártyák, ahol rengeteg műszaki paraméter ismertetésre kerül az
adatlap alapján. Itt az segítené a megértést, ha rámutatna a dolgozat,
hogy a feladat szempontjából miért fontos ismerni az adott paramétert.
Sok helyen találunk utalást a System-on-a-chip tehát magának a Xilinx
lapkának, illetve a hordozó alaplap (carrier board) bizonyos
paramétereire keverve. Itt érdemes lehet megkülönböztetni, hogy mi az,
amit maga a processzor tud (pl. 2db SDIO 2.0 interface) és mi az, ami az
alaplapon van (ezekre a vonalakra illesztett X GB-s eMMC).

A boot mode-ok bemutatása szorosan kapcsolódik a feladathoz, itt egy
folyamatábrán lehetne jól ábrázolni, hogy milyen sorrendben kerülnek
kiértékelésre a különböző kapcsolók és a boot medium-ok, hogy
megismerjük a chipen található boot logikát. Sok esetben már az adott
chip adatlapja tartalmaz ilyen ábrát. Még jobban tudja bonyolítani a
képet a secure boot, azt is lehetett volna esetleg itt tárgyalni, hogy
ez miben változtat a boot folyamaton.

A programbetöltés (bootolás) különböző szintjeinek áttekintése hasznos
és logikusan felépített, itt a más platformokra való kitekintések
különösen jók. A hardver első programozása a Petalinux keretrendszerrel
történik. Logikus, hogy először a chip gyártó saját firmware generátorát
használja, és csak ezután tér át a többi általánosabbra (Buildroot,
Yocto). A dolgozat további részeiben pedig mindkét keretrendszer
bemutatásra kerül. Végül a firmware frissítés kerül megvalósításra a
Petalinux keretei között. Itt külön a bootloader, kernel és a device
tree frissítése is megvalósul majd végül a web felületről történő teljes
firmware letöltés.A dolgozat alapvetően jól olvasható, a gépelési és a
mondat szerkesztési hibák csak néhány helyen zavarják a megértést.
Vannak részek, ahol érezhető az angol szöveg tükörfordítása, ezeket
érdemes lett volna átfogalmazni. Bizonyos kifejezéseket pedig felesleges
is lehet magyarra fordítani, könnyebben érthető például a device tree az
eszközfa helyett, kép helyett az image vagy lemezkép, de ezeket nem
könnyű eldönteni. Néhány helyen pedig pont talán a magyar szó lenne az
érthetőbb (például sourceolás helyett betöltés). Többször van használva
a diplomaterv 1-2 tárgyak neve, mint utalás, hasznosabb lehet a dolgozat
vagy munka névvel hivatkozni a szövegre.

Egy Linux beágyazott rendszer összeállítása komplex feladat, sok
komponensből épül fel, ezek szorosan kapcsolódnak a hardverhez ráadásul
itt heterogén platformról van szó, nem elég csak az ARM magokon kódot
futtatni. Ehhez pedig gyakran kevés dokumentáció áll rendelkezésre és
sok eltérő területről kell specifikus tudást szerezni (operációs
rendszer és bootloader illesztése hardverhez, alacsony szintű
programozás) és sok hardver specifikus eltérés lehet a rendszerek
között. Összességében a dolgozatban sikerült feléleszteni a kártyákat,
komponenseket külön frissíteni, valamint áttekinteni a teljes firmware
előállítás és frissítés főbb részleteit, ezzel a hallgató igazolta, hogy
képes önálló problémamegoldásra és összetett beágyazott rendszerek
szoftverfelépítésének áttekintésére.

A bíráló kérdései a dolgozattal kapcsolatban:

1.  Az upstream Buildroot forrása nem tartalmaz board konfigurációs
    fájlt a tárgyalt fejlesztőkártyákhoz. Milyen lépéseken keresztül
    lehetne létrehozni egy ilyet, hogy így egy Buildroot-tal lefordított
    Linux rendszert be lehessen indítani a kártyákon?
2.  A munka során olyan keretrendszerek lettek említve, (Buildroot,
    Yocto), amik a Linux rendszer szoftverkomponenseit forráskódból
    állítják elő, tehát mindent egyedileg fordítanak le. Van-e lehetőség
    arra, hogy egy már meglévő Linux disztribúciót (pl. Ubuntu)
    indítsunk el a kártyákon, ha igen akkor milyen módosítások
    kellhetnek ehhez? A dolgozat a beágyazott Linux rendszerek
    fejlesztése során felmerülő gyakori problémák közül többet is
    sikeresen old meg, így a dolgozat elfogadását javaslom.

Budapest, 2021. június 25. Jenei Dávid okl. villamosmérnök
