# ParseHistory
Plugin created to store the parse performed in Dummys.

You can use Command line option for open windows:

/Parse open dummy -> Open Parses for Dummy\
/Parse open bosses -> Open Parses for Bosses\
/Parse clean bosses -> Clean Parses Bosses\
/Parse clean dummy -> Clean Parses Dummy

For record Dummy parses you just need to for a Dummy and make parses the plugin will register data every time a parse 3mim ending.
For record Bosses just make one of the instances and the plugin will register Parse made on Boss. If not register send a message on Lotro Interfaces comments for add the boss you need.

## Installation Instructions

Unzip the file in your folder:
C:\Users\[name of your user]\Documents\The Lord of the Rings Online\Plugins

And then you just need to open the LOTRO and load the plugin in the plugin manager.

ChangeLog
===============================================
v.0.0.1 = Beta version for test.\
v.0.0.2 = Add command line option\
v.0.0.3 = Improving code structure\
v.0.1.0 = Fix bug on reding decimal shifted pares, apply visualization like 200.5k insted 200,500.02 (This version will clean old parses to work properly).\
v.0.1.1 = Fix folders\
v.0.2.2 = Cpu usage improvement, implement CombatDecisor.\
v.1.2.2 = Add Boss tracker for Parses made on Bosses. You can tipe now /parse open bosses to see the parses made on Gundabad Bosses Instances. (BETA VERSION)
v.1.2.3 = Fix bug found in v.1.2.2 prevent nil records on data file. (BETA VERSION)

Next plans
===============================================
- [x] Change the show number from 200,0123,111 for 200,01k
- [x] Records Parses from some specific Bosses.
- [ ] New UI for show Datas record for Bosses and Dummys
- [ ] Add more Bosses in the Tracker. 
