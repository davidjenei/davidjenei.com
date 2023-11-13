tags: #student
description: Opposition
maturity: 🌻
title: „Okos kaptár tervezése és megvalósítása” című szakdolgozatának bírálata

X.Y „ Okos kaptár tervezése és megvalósítása ” című szakdolgozatának bírálata
===================================================================================

A dolgozat a hálózatba kapcsolt beágyazott rendszerek egy mezőgazdasági
alkalmazását mutatja be. Az elkészült rendszer célja a méztermelés
folyamatának felügyelete, ami a gyakorlatban a méh kaptárak különböző
szenzorok együttes alkalmazásával történő megfigyelését jelenti.

A bevezetésben a piacon már elérhető termékek és főbb hiányosságaik
kerülnek röviden bemutatásra, így a tervezett rendszer valós igényekhez
igazodik, valamint ezzel a jelölt a piac feltérképezés folyamatával is
megismerkedett a munka során. A dolgozat első fejezetében bemutatásra
kerül a motiváció, az olvasó ezzel megismerheti, milyen kártevők és
betegségek fenyegetik a méheket, később pedig kifejtésre kerül, hogy a
termelés hatékonysága hogyan növelhető szenzorok segítségével.

A szakdolgozat keretében egy komplett felügyelő rendszer beágyazott
komponensének prototípusa kerül elkészítésre, így a tervezés során
bemutatásra kerül, hogyan illeszkedik majd az eszköz a szerver oldali
komponensekhez vagy a mobil klienshez. A munka során a jelölt ezzel
megismerhette a rendszer integráció problémáit, valamint a csapatban
végzett mérnöki munka sajátosságait.

Az elkészített eszköz egy prototípus, így az alkatrészek vagy
komponensek kiválasztásánál a legnagyobb szerepet a hozzáférhetőség és a
meglévő szoftveres támogatás játszotta. A megkérdezett méhészek
elmondása alapján a kiválasztott tömeg illetve hőmérséklet szenzorok
pontossága elegendő. A vezeték nélküli kommunikáció központi jelentőségű
az ilyen rendszerekben, de a dolgozatban csak részben kerül bemutatásra
milyen szempontok alapján lett ehhez protokoll kiválasztva. Bemutatásra
kerülnek viszont a beágyazott rendszerekben gyakori publish/subscribe
alapú alkalmazás rétegbeli protokollok. A munka fő kihívását a szenzorok
integrálása adja, így a prototípushoz elkészítésre került egy nyomtatott
áramkör, amivel a különböző off-the-shelf alkatrészek könnyen
integrálhatóak. A jelölt ennek megfelelően, egy hardver tervezési
feladatot is meg kellett oldjon.

Beágyazott rendszerek esetén az energiagazdálkodás egy kulcskérdés, és a
dolgozat is nagy hangsúlyt fektet erre. Az összefoglalásban található
számítások alapján a rendszer várhatóan kedvező fogyasztással tud majd
üzemelni, így ritkán kell azt karbantartani. A mérések során a maximális
áramfelvétellel történik a becslés, itt hasznos lett volna egy hosszabb
időtartamú mérés, ami több információt adna a valós fogyasztásról,
illetve érdemes lett volna a különböző vezeték nélküli protokollok
hatását, vagy a mérési gyakoriság fogyasztásra gyakorolt hatását
vizsgálni.

A dolgozat logikusan felépített és jól tagolt. Az rendszertervről
készült ábrák hasznosak, de egy hasonló ábra a szoftver komponensek
kapcsolatáról nagyban segítette volna a megértést. A dolgozatban
előfordulnak gépelési és mondat szerkesztési hibák, de ezek az
érthetőséget nem befolyásolják.

A dolgozat során a prototípus fejlesztés számos lépésével megismerkedett
a jelölt, amelyek sikerességét a rendszer integráció és verifikáció
igazolta. A műszaki tartalmát tekintve pedig a dolgozat bemutatta, hogy
ma off-the-shelf szenzorokból, IoT keretrendszerek segítségével és magas
szintű programozási nyelvek mikrokontrollereken történőalkalmazásával
milyen gyorsan és hatékonyan fejleszthetőek beágyazott rendszerek.
Ezekkel az eszközökkel pedig a jelölt sikerrel elvégezte a feladatot.

A bíráló kérdései a diplomamunkával kapcsolatban:

1.  A tervezett karbantarthatóság beágyazott rendszereknél is fontos
    kérdés. Hogyan lehetne előre jelezni a karbantartás várható idejét?
2.  Milyen konfigurálható paraméterei vannak a rendszernek, illetve
    hogyan lehetne ezeket távolról megváltoztatni (pl. mérési
    gyakoriság)
3.  Hálózati problémák esetén hogyan viselkedik a rendszer, illetve
    milyen stratégiával lenne érdemes az üzeneteket újraküldeni egy sok
    elemből álló hálózat esetében?

Összességében a dolgozat lefedte a mérnöki munka számos területét és
több, a beágyazott rendszerek fejlesztése során felmerülő gyakori
probléma is megoldásra került, ezért javaslom a dolgozat elfogadását.

Budapest, 2019-01-03 Jenei Dávid okl. villamosmérnök
