KOREN ZOLTÁN "LEVEGŐ MINŐSÉGÉNEK VIZSGÁLATA IOT MEGOLDÁSSAL" CÍMŰ SZAKDOLGOZATÁNAK A BÍRÁLATA
=============================================================================================

A levegő minőségének mérése napjaink egy aktuális kérdése és várhatóan
csak egyre fontosabb lesz a következő években. A dolgozat ezen belül
kifejezetten a beltéri mérésekre koncentrál, ami tantermekben különösen
fontos. A szenzorok árának csökkenésével és új off-the-shelf hardverek
megjelenésével pedig egyre több lehetőség nyílik egyedi adatgyűjtő
rendszerek kiépítésére, amik segítségével később a szellőztető vagy akár
levegő tisztitó rendszerek működése finomhangolható.

A dolgozat első fejezetében áttekinti, hogy a környezet mely fizikai
paramétereinek vannak kognitív élettani hatásai (nem csak a levegőre
korlátozva) így próbálja meghatározni mik lesznek a mérendő mennyiségek.
Itt érdekes volt látni a szabványokban milyen értékeket határoznak meg,
esetlegesen a munkavédelmi szabályozásokban foglaltakat is ide lehet
venni.

A második fejezetben a felhasznált hardvereszközök bemutatása történik.
Megfelelő részleteséggel történik a műszaki paraméterek leírása, nem
feleslegesen részletes. A harmadik fejezetben a vezetéknélküli
kommunikációra használt technológiákat hasonlítja össze, ez szintén
összeszedett és elegendő részleteséggel mutatja be a használt
technológiát.

A negyedik fejezettől áttér a gyakorlati megvalósításra, ezután erre
illeszkedik a megjelenítés bemutatása a következő fejezetben. Itt a
mikrokontroller és Linux alapú adatkoncentrátor szoftvere egyaránt
bemutatásra kerül, itt lehet érdemes lett volna ezeket jobban
elválasztani egymástól. Néhány helyen módosításra került a
mikrokontrolleren futó kód is, itt néhány kódrészlet érdekes lett volna,
hogy az egész program felépítése jobban érthető legyen. Az
adatkoncentrátoron futó kód bemutatása részletes. A dolgozat a mérés
bemutatásával végül pedig az eredmények kiértékelésével zárul.

A dolgozat több fejlesztés közben felmerülő problémát is tárgyal, itt
érdemes a hibák lokalizálásra használható technikákat megemlíteni,
például hogyan hogyan lehet megbizonyosodni arról, hogy a memória
kezelési probléma nem a saját programkódban, hanem a felhasznált
függvénykönyvtárban van.

Az adatmegjelenítésre érthető, hogy egy már korábban használt könyvtárat
választ a hallgató, de a választott programnyelvhez sok másik
adatvizualizáló könyvtár is elérhető, köztük olyanok is, amik egyből web
alapú vizualizálást is támogatnak (pl. Plotly) így lehetőség lenne
egyszerűsíteni a rendszert.

A szöveg logikusan felépített és jól tagolt. A dolgozat több ábrát is
tartalmaz, amik segítik a megértést, de érdemes lehet a programkódot
vagy a rendszert leíró diagramokhoz valamilyen szabványt például SysML
vagy UML komponens diagramot használni. A dolgozatban nagyon kevés a
gépelési hiba, ezek az érthetőséget nem befolyásolják. Az új
technológiák és fogalmak bevezetése érthető és lényegre törő.A
megoldandó feladat komponensekre bontása és a keretrendszerbe illesztése
átgondolt és alaposan megtervezett. A dolgozat a hálózatba kapcsolt
beágyazott vagy IoT rendszerek építése során több gyakori
rendszerkomponenst is megvalósít és integrál (szenzorillesztés,
vezetéknélküli adatgyűjtő és feldolgozó szoftver készítése,
megjelenítés, etc.) a munka egy egész rendszer építését bemutatja.

A bíráló kérdései a dolgozattal kapcsolatban:

1.  A BLE adatgyűjtéshez használt függvénykönyvtárral (gattlib)
    kapcsolatban több problémát is említ a dolgozat. Milyen alternatívák
    léteznek, illetve lehetséges-e az említett BlueZ használata erre a
    feladatra?

2.  A dolgozat két magas szintű interpretált programnyelvet is használ a
    (Javascript (Node.js) és Python). Van-e lehetőség itt az
    architektúra egyszerűsítésén úgy, hogy csak az egyik valósítsa meg
    az összes funkciót?

A dolgozat a hálózatba kapcsolt beágyazott rendszerek fejlesztése során
felmerülő gyakori problémák közül többet is sikeresen old meg, így a
dolgozat elfogadását javaslom.

Budapest, 2022. január 3. Jenei Dávid okl. villamosmérnök
