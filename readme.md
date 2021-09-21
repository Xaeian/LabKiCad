---
Emilian Świtalski | es@sqrt.pl
Repozytorium stanowi element warsztatów z projektowania urządzeń elektronicznych i celowo jest pozbawiony postępów realizacji prac.
---

## KiCad _"od koncepcji do gotowego urządzenia"_

KiCad jest w zasadzie zbiorem programów, których ogólnym przeznaczeniem jest projektowanie obłodów drukowanych na płytkach PCB.

![KiCad](/image/kicad.png)

W pakiet KiCad wchodzą:

- **eeschema** - Program do rysowania schematów
- **pcbnew** - Program do projektowania PCB (rozmieszczanie elementów i realizacja połączeń)
- **gerbview** - Program do przeglądania plików produkcyjnych GERBER
- **bitmap2component** - Program konwertujący obraz `.bmp` oraz `.jpg` na komponent dostępny z poziomu **pcbnew**
- **pcb_calculator** - Pomocniczy programik pomocny w często wykonywanych obliczeniach
- **pl_editor** - Edytor ramek dla **eeschema** oraz **pcbnew**

Programy dobrze z sobą współpracują, jednak nadal są oddzielnymi bytami, które mogą być wykorzystywane niezależnie lub z innymi programami. Taka koncepcja sprawia, że rozwiązania które **KiCad** wykorzystuje, wydają się przekombinowane względem sandbox'owego **Eagle** czy **Altium Designer**.

## Biblioteki

Na początek warto korzystać z bibliotek instalowanych razem z programem, jednak im dłużej pracujemy z programem KiCad, tym więcej komponentów będziemy tworzyli samodzielnie lub dodawali z internetu. 

_Koniec końców po 5 latach pracy z wywalimy wszystkie standardowe biblioteki i sami zrobimy z tym porządek. U mnie tak się stało, kiedy KiCad przeszedł z wersji `4` do `5` i w związku ze zmianą struktur bibliotek wszystkie projekty mi się rozsypały._

Dlatego razem z kursem dołączona jest okrojona wersja bibliotek, która jest wystarczająca, żeby zrealizować prosty projekt przygotowany w kursie:

- `{URL}\liblary\Symbols\` - Biblioteki zawierające symbole
  - Pliki w formacie `.lib`
- `{URL}\liblary\Footprints\` - Biblioteki zawierające footprint'y _(komponenty)_
  - Pliki w formacie `.kicad_mod`
- `{URL}\liblary\Models\` - Biblioteki zawierające modele 3D 
  - Pliki w formacie `.step` lub `.wrl`

Oczywiście `{URL}` jest lokalizacją, gdzie zostało sklonowane repozytorium z kursem. Wygodnie jest każdą z tych ścieżek dodać w programie jako ścieżkę względną:

![Path](/image/path.png)

- `LSB` - Ścieżka dostępu do bibliotek z symbolami
- `LFB` - Ścieżka dostępu do bibliotek komponentami
- `L3D` - Ścieżka dostępu do bibliotek z modelami 3D

Wówczas dodając bibliotekę, będziemy mogli odnosić się do utworzonych ścieżek. Biblioteki można dodawać z poziomu programu, jednak w dłuższej perspektywie praktycznej jest edytować pliki za to odpowiedzialne.

Informacją jakie biblioteki **symboli** będą widoczne z poziomu programu **eeschema** określa się w pliku `sym-lib-table`.

Informacją jakie biblioteki **footprint'ów** będą widoczne z poziomu programu **pcbnew** określa się w pliku `fp-lib-table` w lokalizacji.

Oba pliki muszą znajdować się w lokalizacji:

    C:\Users\{USER}\AppData\Roaming\kicad

Zatem przed uruchomieniem programu udajmy się pod podaną lokalizację i przekopiujmy pliki `sym-lib-table` oraz `fp-lib-table` z folderu `{URL}\liblary\`.

## Koncepcja

Rysowanie schematów nie wydaje się trudne, nie mniej wymaga nieco wprawy, a przede wszystkim pomysłu. Musimy wiedzieć, co rysujemy lub projektujemy.

Załóżmy, że otrzymaliśmy zlecenie na zaprojektowanie urządzenie, które ma migać diodą, z dostrajaną przez urzytkownika częstotliwością (nie ważne w jakim zakresie). Sposobów na realizację takiego projektu będzie przynajmniej kilka, ale my wykożystamy mikrokontoler, a dokładnie populany układ `Atmega328P`.

Prostym sposobem na różnego rodzaju regulację jest wykorzystanie potencjometru oraz przetwornika `ADC`. Miganie diodą można zrealizować poprzez zmianę stanu na pinie i odczekanie pewnego odcinka czasu `_delay_ms(x)`, jednak bardziej elegancko wykorzystać `PWM`. Jak co nieco pracowaliśmy z procesorami **AVR** lub **Arduino** to dobranie pinów z [tą ściągawką](https://github.com/Xaeian/labs-avr#speed-run-avr) nie powinno stanowić problemu. W przeciwnym wypadku podłączymy diodę i potencjometr do dowolnego pinu.

Jak ktoś nie do końca wie jak podłączyć **mikrokontroler**, **potencjometr**, czy sterować diodą LED to poniższy rysunek powinien wyjaśnić sprawę.

![Schema](/image/schema.png)

W praktycznej implementacji można jeszcze dodać stabilizator **LDO** oraz złącze zasilania, np. **Power Jack**.

## Rysowanie schematu

Pora utworzyć nowy projekt i wejść do programu **eeschema**.

![Eeschema](/image/eeschema.png)

_Niektóre narzędzia nie są dostępne z poziomu pasków bocznych. Jest to nieznośnie dla nowych użytkowników, gdyż niektóre z nich są niezbędne efektywnego tworzenia schamatu._

Na początek najlepiej dodać wszystkie wykorzystywane komponenty (`A`) oraz tagi zasilania (`B`). Porozmieszczać (`M`,`G`), a na koniec odpowiednio połączyć (`W`). Nie wykorzystywane wyprowadzenia mikrokontrolera oznaczyć krzyżykiem (`Q`). Ważne jest dobranie wartości elementów (`V`) oraz ponumerowanie _(nadanie referencji)_ (`U`). Gdy nie jest dla nas istotne, jaki komponent będzie miał jaki numer, możemy skorzystać z numerowania automatycznego:

![Number](/image/number.png)

Jeżeli chcemy korzystać z kontroli błędów, konieczne jest połączenie symboli zasilania z symbolami _flag_. Wówczas program ma informacje, które ze ścieżek doprowadzają zasilanie. 

![Flag](/image/flag.png)

Poza uzupełnieniem wartości _(**Value**)_ oraz oznaczeniem _(**Reference**)_ konieczne jest przypisanie **Footprint**'u do symboli. Można zrobić poprzez edycje pól dla każdego symbolu z osobna (`E`) lub globalnie (toolbar).

![symbol](/image/symbol.png)

Można do symbolu możemy wskazać link d dokumentacji _(**Datasheet**)_. Pozostałe pola: **Manufacturer**, **Code**, **Supplier**, **Description** standardowo nie występują w programie KiCad, jednak są bardzo użyteczne, ponieważ w sytuacji, gdy montaż urządzenia będzie wykonywał ktoś inny, pozwalają precyzyjnie określić, jaki element ma zostać zamówiony, gdzie możemy go kupić oraz czym się kierować podczas doboru.

_Footprint'y możemy również przypisywać za pomocą dedykowanej do tego aplikacje, lecz w moim subiektywnym odczuciu narzędzie _"edycja pól symboli"_ jest po prostu lepsze._

Elementów możemy szukać u dystrybutorów:
- [TME](https://www.tme.eu/pl/);
- [Mouser](https://pl.mouser.com/);
- [Digikey](https://www.digikey.pl/);
- [Farnel](https://pl.farnell.com/);
- [Maritex](https://www.maritex.com.pl/);

oraz bezpośrednio u producentów:
- [ST Microelectronic](https://www.st.com/);
- [Texas Instruments](https://www.ti.com/);
- [Microchip](https://www.microchip.com/);
- [Infineon](https://www.microchip.com/);
- [Vishay](https://www.vishay.com/);
- [Diodes Incorporated](https://www.diodes.com/);
- [Würth Elektronik](https://www.we-online.com/catalog/en).

## Projektowanie PCB

Na koniec zabawy ze schematem należy wygenerować listę sieci _(**netlist**)_, przejść do programu **pcbnew** i tą listę załadować.

![netlist](/image/netlist.png)

Wszystkie dobrane na etapie rysowania schematu komponenty powinny rozsypać się w oknie roboczym. Zanim jednak przejdziemy do projektowania dobrze ustawić reguły projektowe takie jak grubości ścieżek i rozmiary przelotek.

![settings](/image/settings.png)

Ustawienia z grafiki wyżej są odpowiednie dla wykonywania budżetowych płytek w firmach zajmujących się produkcją PCB. Gdy byśmy chcieli płytkę wykonać samodzielnie, ścieżki powinny być grubsze, a odstępy większe.

Jednak płytki PCB to nie tylko miedziane ścieżki i miejsca, gdzie miedź została wytrawiona lub zdrapana. Dlatego w programie mamy do czynienia z warstwami _(**layers**)_

![layers](/image/layers.png)

Warstwy z przedrostkiem `F.` odnoszą się do górnej _(Top)_ strony płytki, natomiast `B.` do dolnej _(Bottom)_.
Podczas stawiania pierwszych kroków warstwy oznaczone na ilustracji jako **TIER2** można całkowicie zignorować:
- `F.Cu`, `B.Cu` - Warstwy miedzi;
- `F.Adhes`, `B.Adhes` - Warstwy kleju;
  - Gdy połączenie lutowane jest nie wystarczające, by mechanicznie utrzymać komponent;
- `F.Paste`, `B.Paste` - Warstwy dla pasty lutowniczej;
- `F.SilkS`, `B.SilkS` - Warstwy opisów na płytce;
- `F.Mask`, `B.Mask` - Warstwy pól lutowniczych;
  - Na niej nie zostanie umieszczona **soldermaska**;
- `Dwgs.User`, `Cmts.User` - Warstwy opisów dla urzytkownika
  - Dodatkowe informacje, takie jak wymiary;
- `Eco1.User`, `Eco2.User` - Warstwy bez przeznaczenia;
- `Edge.Cuts` - Warswa krawędzi płytki oraz frezów;
- `F.CrtYd`, `B.CrtYd` - Warstwy zajętości komponentu;
  - Gdy warstwy zajętości różnych elementów nachodzą na kontrola błędów to wykryje;
- `F.Fab`, `B.Fab` - Warstwa montażowa
  - Jest eksportowana jako dokumentacja montażowa;

Teraz wystarczy:
- wyznaczyć obrys płytki;
- wyznaczyć punkt początkowy płytki _(lewy-górny róg)_;
- rozstawić odpowiednio elementy;
- połączyć je zgodnie z sugestiami programu;
- dodać strefę miedzi przyległą do GND _(**polygon**)_

![pcbnew](/image/pcbnew.png)

Brzmi prosto, ale takie nie jest! Na szczęście na koniec jesteśmy nagrodzeni widokiem 3D naszej płytki PCB wraz z zamontowanymi elementami (`Alt` + `3`). Jeśli jesteśmy zadowoleni z rezultatu, możemy wygenerować dokumentację produkcyjną, na którą składają się:
- `1.` Pliki **GERBER**
- `2.` Pliki wierceń
- `3.` Lista materiałowa **BOM**
- `4.` Dokumentacja montażowa
- `5.` Rozmieszczenie elementów **Pick&Place**

![gerber](/image/gerber.png)

Gdy montaż realizujemy samodzielnie, wystarczy wykonać punkty `1` i `2`.
Punkt `5` konieczny jedynie przy dużej, zautomatyzowanej produkcji.

















