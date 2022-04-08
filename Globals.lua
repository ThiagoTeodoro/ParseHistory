------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

--Initialization of variables
DummyParseHistory = {};
WindowForDummys = nil;
ViewPortCaptionDummy = nil;
ViewPortDummy = nil;
VScrollDummy = nil;
BestParseValueOnDummy = 0;
BestParseText = nil;
ChatMonitor = Turbine.Chat;
PlayerMonitor = Turbine.Gameplay.LocalPlayer.GetInstance();



--Constants
Event = {
	MecOrEnvOrKilled = 0,
}

--Boss Target's Monitor
BossParseHistory = {};
BestParseValueOnBoss = 0;
Battle = {}
CombateStart = nil;
CombateEnd = nil;
Boss = {	
	"Naruhel",
	"Warlord Dushtalbúk",
	"Hrímil Frost-heart",
	"Kvethár",
	"Armód",
	"Threkvegg",
	"Arváng Blackfoot",
	"Náli the Thumb-taker",
	"Níthi the Cunning",
	"Andvár Crow-feeder",
	"Loknashra",
	"Vethúg Wintermind",
	"Kordkoth",
	"Pughlak",
	"Mozrúk the Wind-rider",
	"Shaikmuz",
	"Mozrúk",
	"Gâdh-and-Shum",
	"Velzájar",
	"Shakalog",
	"Grazmauk",
	"Ulshatarg"
};