




## KiCad - od koncepcji do gotowego urządzenia


KiCad jest w zasadzie zbiorem programów, których ogólnym przeznaczeniem jest projektowanie obłodów drukowanych na płytkach PCB.

![KiCad](/image/kicad.png)

W pakiet KiCad wchodzą:

- **eeschema** - Program do rysowania schematów
- **pcbnew** - Program do projektowania PCB (rozmieszczanie elementów i realizacja połączeń)
- **gerbview** - Program do przeglądania plików produkcyjnych GERBER
- **bitmap2component** - Program konwertujący obraz `.bmp` oraz `.jpg` na komponent dostępny z poziomu **pcbnew**
- **pcb_calculator** - Pomocniczy programik pomocny w często wykonywanych obliczeniach
- **pl_editor** - Edytor ramek dla **eeschema** oraz **pcbnew**

## Biblioteki

W programie **eeschema** tworzymy schematy 




---

Wygodnie jest umieścić lokalizację katalogów z bibliotekami jako ścieżkę dostępu. 

![Path](/image/path.png)

- `LSB` - Scieżka dostępu do biblioteki zawierającej symbole
  - Pliki w formacie `.lib`
- `LFB` - Scieżka dostępu do biblioteki zawierającej **footprint'y** _(komponenty)_
  - Pliki w formacie `.kicad_mod` 
- `L3D` - Scieżka dostępu do biblioteki zawiarającej modele 3D
  - Pliki w formacie `.step` lub `.wrl`

Wówczas dodając bibliotekę będziemy mogli odnościć się do utworzonych ścieżek. Biblioteki można dodawać ręcznie z poziomu programu, jednak w dłuższej perspektywie praktycznej jest robić to ręcznie.

Informacją jakie biblioteki **symboli** będą widoczne z poziomu programu **eeschema** okresla się w pliku `sym-lib-table`.

Informacją jakie biblioteki **footprint'ów** będą widoczne z poziomu programu **pcbnew** okresla się w pliku `fp-lib-table` w lokalizacji.

Oba pliki muszą znajdować się w lokalizacji:

    C:\Users\{USER}\AppData\Roaming\kicad


Gdy mamy już pobranie i skonfigurowane biblioteki możemy przejść do 





## KiCad - od koncepcji do gotowego urządzenia



### Dystrybutorzy-Sklepy
  - TME tme.pl
  - 


### Dystrybutorzy-Firmy


### Producenci



### Eeschema

- Opracowanie koncepcji
- Narysowanie schematu
  - Rozmieszczenie symboli
  - Realizacja połączeń między nimi
  - Dobieranie komponentów do symboli
  - Uzupełnianie referencji _(numerowanie)_
- Generowanie listy elementów

### Pcbnew

- Wczytanie listy elementów
- 


![Eeschema](/image/eeschema.png)

Niekture narzędzia nie są dostepne z poziomu pasków bocznych. Jest to tym bardziej nieznośnie dla nowych użytkowników, że nie które z nich są narzędziami niezbednymi do efektynego tworzenia schamatu. ....

![gerber](/image/gerber.png)

![layers](/image/layers.png)
![netlist](/image/netlist.png)
![path](/image/path.png)
![pcbnew](/image/pcbnew.png)
![schema](/image/schema.png)
![settings](/image/settings.png)
![symbol](/image/symbol.png)