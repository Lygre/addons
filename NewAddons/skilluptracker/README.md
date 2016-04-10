**Author:** Mujihina
**Version:** v 1.02

# Skillcaps #

This addon will keep track of your current skill levels (as a floating number) and their caps. Skill levels are updated and stored as they increase:
- Once the add-on is installed, a message such as this:
```
Name's enhancing magic rises by 0.1
```

will be replaced with
```
Name's enhancing magic rises by 0.1 (195.6/200)
```

- Windows showing your current skill magic, combat, and craft levels can also be shown. They are hidden by default.

# Command #

Syntax can be obtained by running the command without arguments, or with the subcommand 'help'

The command is only to control the display of your skill windows. Current syntax is:

- skilluptracker [show|hide] [all|craft|magic|combat]: 

Aliases:
- 'sut' = 'skilluptracker'
- 's' = 'show'
- 'h' = 'hide'
- 'a' = 'all'
- 'cr' = 'craft'
- 'm' = 'magic'
- 'co' = 'combat'

##Examples:##
Show all windows
```
sut s a
```

Hide Crafting window
```
sut h cr
```

##Notes##
- Keep in mind that if you are wearing equipment that increases your skill levels, the first time you run the add-on, these numbers will be innacurate.
-  As you skill-up, the stored numbers will become more accurate.
- A .xml file will be created for each character under /data.

##TODO##


##Changelog##

### v1.02 ###
   Minor changes and fix for issue when changing chars too fast.

### v1.01 ###
   Small fixes to compensate for lua's weird handling of floats.

### v1.0 ###
* First release.
