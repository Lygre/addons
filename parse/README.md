# parse
An FFXI Parser Addon for Windower. This addon parses both offensive and defensive data, stores WS/JAs/spells data by individual spell, tracks additional information like multihit rates, and provides the ability to export/import data in XML format.

### Commands

`//parse pause`
Pauses the parser.

`//parse reset`
Resets the currently stored data.

`//parse report [stat] [chatmode]` Reports stat to party. 
If [stat] not provided, will report damage. Valid stats include, but aren't limited to:
* damage (% reported is player's portion of total damage)
* melee | ranged (% reported is hit rate)
* crit | r_crit
* multi (reports percent and cardinality of double attacks, triple attacks, etc., but does not distinguish between OAX)
* block | parry | evade (% reported is based on action hierarchy; for example, block % excludes evades and parry % excludes both evades and non-engaged hits taken)
* ws | ja | spell (reports averages for total category, and each individual spell)

If [chatmode] not provided, will print to personal chatlog. Valid chatmodes include:
* p: party
* s: say
* l: linkshell
* l2: linkshell2
* t [player name]: tell

`//parse show (melee|ranged|magic|defense)`
Toggles visibility of each display box. Note that while data is still parsed regardless of visibility, these displays are not updated unless visible, saving resources.

`//parse interval [number]`
Changes the interval rate at which the display boxes are updated. The default is '3', meaning the displays will update every three recorded action packets.

`//parse filter (add|remove) [substring]`
Adds/removes substring to filter list.

`//parse filter clear`
Clears filter list.

`//parse list (mobs|players)`
Lists mobs and players that are found in database.

`//parse rename [player/monster name] [new name]`
Renames a player or monster to a new name for all future, incoming data. To rename again, always use the original name. Replace any spaces with _ and exclude all commas.

`//parse (export|import) [file name]`
Exports/imports data to/from the "parse/data/export" folder. Imported data is merged with any current in-game data. If file name is taken, it will append os.clock. NOTE: Exported data will be saved according to any current filters.

`//parse autoexport [file name]`
Automatically exports database every 500 actions. This interval can be changed in settings under autoexport_interval. Use command again with no file name, or 'off' to turn it off.
