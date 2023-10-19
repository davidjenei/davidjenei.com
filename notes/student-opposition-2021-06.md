tags: #student

Czurkó Dániel “Objektumok felismerése és követése felhőből vezérelt drónokkal” című szakdolgozatának bírálata
=============================================================================================================

A drónok vagyis a pilóta nélküli repülőgépek széleskörű alkalmazását a
közelmúlt egyik legnépszerűbb technológiai újdonságként tartják számon.
Olyannyira, hogy a Gartner elemző cég értelmezésében, a sokak által
ismert hype-görbe öt fázisa közül feltehetően épp napjainkban fordul át
“technology trigger” vagyis a technológiai áttörésből az "inflated
expectations" vagy túlzott elvárások fázisába. A nagy érdeklődés egyik
oka az, hogy sok egymástól nagyon eltérő probléma megoldására is
alkalmazhatóak, amikben az a közös, hogy emberek által nehezen vagy nem
gazdaságosan elérhető területeket kell megfigyelni, vagy ott valamilyen
feladatot elvégezni. A dolgozat témája pedig ezeknek a feladatoknak egy
szűkebb csoportját az objektumkövetést célozza meg.

A dolgozat első fejezetében a hallgató bemutatja milyen gyakorlati
alkalmazásai vannak az objektumkövetésnek és hogy mik lehetnek a
felmerülő akadályok. Kiemeli a szimuláció fontosságát, valamint
bemutatja a technológiákat, amikkel ezt a komplex számítási feladatot
alacsony válaszidővel el lehet elvégezni. Ezek közül elsőként a gépi
tanulást részletezi a következő fejezetben, és bemutat néhány objektum
felismerésére használt algoritmust. Az algoritmus választásának fő
szempontja a pontosság és válaszidő kérdése, ehhez összehasonlító
méréseket végzett a hallgató. Itt érdemes lett volna részletezni, hogy
ezt milyen platformon végezte, illetve, hogy milyen tényezők
befolyásolhatják az eredményeket. A következő kulcs technológia a gépi
látás, itt objektum követésre alkalmas kamera és szenzor típusokat
hasonlít össze röviden.

A harmadik fejezetben a szimulációs szerver környezet kialakítását
mutatja be. Itt minden szerver komponens Linux konténerben kerül
telepítésre azért, hogy könnyen reprodukálható legyen a folyamat. A
távoli eléréshez VPN szerver is kialakításra kerül. Felmerülhet a kérdés
hogyha csak egy webalkalmazást kell elérni nem egyszerűbb egy reverse
proxy és egy authentikációs szerver használata, de a hallgató kiemeli,
hogy esetleg szükség lehet néhány szerver közvetlen elérésére is.

A negyedik fejezet elején az objektumkövető rendszer tervezési kérdéseit
mutatja be. A megoldandó feladatot két komponensre bontja és
felhasználja, hogy a keretrendszer a komponensek közötti kommunikációra
már ad egy szabványos megoldást. Valószínűleg segítette volna a
megértést, ha ez a protokoll már itt részletesebben bemutatásra kerül.
Az egyedi node-ok megvalósítása részletesen az ötödik fejezetben kerül
bemutatásra. Itt szintén hangsúlyos, hogy container-ekben kerülnek
telepítésre a komponensek hasonlóan, off-the-shelf rendszer elemekhez.

A szöveg logikusan felépített és jól tagolt. A dolgozat több ábrát is
tartalmaz, amik segítik a megértést, de érdemes lehet nem csak a kódhoz,
hanem a rendszert leíró diagramokhoz is valamilyen szabványt például
SysML vagy UML komponens diagramot használni. Néhány ábra az apró
betűméret miatt nehezen olvasható. A dolgozatban előfordulnak gépelési
hibák, de ezek az érthetőséget nem befolyásolják. Néhány helyen egy új
technológia bemutatásánál egy átfogó egy-mondatos rövid bevezetés
javítaná a szöveg érthetőségét.

A követő algoritmus megvalósítása során sok apró probléma merülhet fel,
amelyek egy része a tesztek során derült ki. A dolgozat azt is
részletezi, hogy szimuláció komplexitását lehet tovább is növelni:
domborzat, felület anyaga, milyen gyorsan mozog az objektum stb., így
idővel az algoritmus tovább bonyolódik. A gépi tanulás és a gépi látás
valós alkalmazásához számos további paraméter finomhangolása szükséges
és a saját algoritmus fejlesztése során is kerülnek újabbak a
rendszerbe. Ezeket hasznos lehet egy összefoglaló táblázatban
áttekinteni még a valóélet-beli alkalmazás előtt.

Jelentős részét teszi ki a dolgozatnak az önálló követő algoritmus
fejlesztése, erre az irodalomjegyzékben kevés forrást találunk. Ezt
leszámítva a dolgozat különböző témáihoz hasznos és releváns források
lettek felhasználva.

A dolgozat során a hallgató egy összetett probléma megoldására
vállalkozott, amit sikerült egy, a szimulációnak megfelelő algoritmussal
megvalósítani. Nagy hangsúlyt kap a gyakorlati megvalósítása a
szimulációs szerver környezet telepítésének és az egyedi komponensek
integrálásának, de viszonylag kevés szó esik a felhasznált számítási
kapacitásról, válaszidőkről, illetve a Linux container-ek és a GPU
használatának kapcsolatáról. A megoldandó feladat komponensekre bontása
és a keretrendszerbe illesztése átgondolt és alaposan megtervezett. A
dolgozat sok különböző témát érintett (gépi tanulás, gépi látás,
elosztott számítási architektúrák, szerver szoftver telepítés,
algoritmus fejlesztés), ilyenkor a bevezetés során érdemes lehet leírni,
hogy a munka melyik területekre fókuszál leginkább.

A bíráló kérdései a dolgozattal kapcsolatban:

1.  A feladatban egy videó stream feldolgozásával lett megvalósítva az
    objektumkövetés, de említésre kerülnek más lehetséges szenzorok és
    kamera típusok is. A felmerült nehézségek ismeretében milyen más
    szenzor vagy kamera alkalmazásával lehetne javítani az rendszer
    működését?
2.  A munka során hangsúlyos szerepet kapott a szerver komponensek Linux
    container-ekbe csomagolása, amikből jó néhány együttműködése
    szükséges a rendszer futásához. Hogyan lehetne ezeket a
    komponenseket kompakt módon, egy konfigurációként egyszerre
    elindítani?

A dolgozat lefedte a mérnöki munka számos területét és több, elosztott
számítási rendszerek fejlesztése során felmerülő gyakori problémát is
érint, így összességében a dolgozat elfogadását javaslom.

Budapest, 2021. január 5.

Jenei Dávid

okl. villamosmérnök
