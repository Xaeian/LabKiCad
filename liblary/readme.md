## KiCad Liblary

Zawartość Bibliotek:
- `Symbols\` - Biblioteki zawierające symbole
  - Pliki w symboli formacie `.lib` oraz linki do dokumentacji w formacie `.dcm`
  - Folder należy powiązać z zmienną systemową `LSB` w programie KiCad
- `Footprints\` - Biblioteki zawierające footprint'y _(komponenty)_
  - Foldery z footprint'ami w formacie `.kicad_mod`
  - Folder należy powiązać z zmienną systemową `LFP` w programie KiCad
- `Models\` - Biblioteki zawierające modele 3D
  - Pliki w formacie `.step`, niekiedy projekty **FreeCAD** w formacie `.FCStd`
  - Folder należy powiązać z zmienną systemową `L3D` w programie KiCad
- `frame.kicad_wks` - pusta ramka dla programów **eeschema** oraz **pcbnew**
- `sym-lib-table` - tabela dla bibliotek symboli
- `fp-lib-table` - tabela dla bibliotek footprint'ów
- `cp-lib-table.sh` - skrypt podmieniający tabele bibliotek

Tabele należy umieścić w poniższej lokalizacji lub użyć skryptu `.sh`

    C:\Users\{USER}\AppData\Roaming\kicad