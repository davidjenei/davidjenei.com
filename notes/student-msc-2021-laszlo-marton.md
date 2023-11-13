tags: #student
description: Master's thesis
maturity: 🌻
title: Konténer-alapú grafikus alkalmazások futtatása beágyazott környezetben

Konténer-alapú grafikus alkalmazások futtatása beágyazott környezetben
======================================================================

Napjainkban a Linux a leggyakrabban alkalmazott operációs rendszer 32
bites alkalmazásprocesszorral rendelkező beágyazott rendszerekben. Az
operációs rendszer fölötti virtualizáció így a Linux konténerek és az
ehhez kapcsolódó infrastuktúra napjainkban már nem csak szerver
szoftverek esetében, de beágyazott rendszerekben is elterjedt. Az
alkalmazások izolálása, modularitás és az automatizált frissítések
lehetősége mind olyan tulajdonságok, amik beágyazott rendszerekben is
előnyösek. Egy lényeges különbség lehet viszont, hogy beágyazott esetben
a futtatókörnyezetnek szenzorokhoz és egyéb perifériákhoz kell
hozzáférést biztosítson az alkalmazásoknak. Ennek egy speciális esete a
grafikus kijelzők és az ehhez kapcsolódó beviteli eszközök
(érintőkijelzők vagy gombok) elérése. Az evopro Innovation-nél több
ipari beágyazott rendszerben is Linux konténerek segítségével történik
az alkalmazások telepítése és karbantantartása, így felmerül a grafikus
megjelenítést igénylő rendszereknél is a felhasználásuk. A hallgató
feladata, hogy áttekintse hogyan alkalmazható a Linux operációs
rendszer-szintű virtualizáció grafikus beágyazott alkalmazásokra és
bemutassa a gyakorlati használatát néhány grafikus könyvtár
segítségével.

A hallgató feladatának a következőkre kell kiterjednie:

- Mutassa be a beágyazott Linux rendszerekben grafikus felhasználói
  felület megvalósításhoz használt leggyakoribb technológiákat
- Tekintse át a megjelenítéshez szükséges szoftver rétegeket (driverek,
  ablakkezelő, grafikus könyvtárak, stb.) és ezek kapcsolatát
- Vizsgálja meg a grafikus alkalmazások Linux kontérekben való
  futtatásának lehetőségeit
- Készítsen grafikus alkalmazásokat a megismert könyvtárakkal és
  keretrendszerekkel Toradex Apalis fejlesztőkártyákra és futtassa
  azokat kontérekben egy beagyázott Linux operációsrendszeren
- Hasonlítsa össze az alkamazott megoldásokat teljesítmény,
  karbantarthatóság és integrálhatóság szempontjából
