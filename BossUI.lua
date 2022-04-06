------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

function SetupWindowForBossParse()

    -- Main Window
    WindowForBosses = Turbine.UI.Lotro.Window();
    WindowForBosses:SetPosition(600, 350);
    WindowForBosses:SetSize(280,420);
    WindowForBosses:SetText("Parse History");

    BestParseOnBossLabel=Turbine.UI.Label()
    BestParseOnBossLabel:SetParent(WindowForBosses);

    -- create a caption for our viewport
    ViewPortCaptionBoss=Turbine.UI.Label();
    ViewPortCaptionBoss:SetParent(WindowForBosses);
end

function ShowBossParses(dataToShow)

    --Cleaning Old ViewPort
    if(ViewPortBoss ~= nil and ViewPortBoss.map ~= nil) then
      ViewPortBoss:SetParent(nil);
      ViewPortBoss.map:SetParent(nil);
    end

    --Reverse order
    dataToShow = ReverseList(dataToShow);

    -- create the viewport control all it needs is size and position as it is simply used to create viewable bounds for our map
    ViewPortBoss=Turbine.UI.Control();
    ViewPortBoss:SetParent(WindowForBosses);
    ViewPortBoss:SetSize(250,250);
    ViewPortBoss:SetPosition(ViewPortCaptionBoss:GetLeft()-40+ViewPortCaptionBoss:GetWidth(),ViewPortCaptionBoss:GetTop()+152);

    -- create the map content for our viewport, again, it only needs size and position as it is just a container for the grid of images
    ViewPortBoss.map=Turbine.UI.Control();
    ViewPortBoss.map:SetParent(ViewPortBoss); -- set the map as a child of the viewport so that it will be bounded by it for drawing purposes
    ViewPortBoss.map:SetSize(250,table.getn(dataToShow)*90); -- we'll use a 5x4 grid but this obviously could be expanded, or even set up as a recycled array of controls
    ViewPortBoss.map:SetPosition(0,0); -- we'll start off in the upper left

    -- create the vertical scrollbar for our viewport
    VScrollBoss=Turbine.UI.Lotro.ScrollBar();
    VScrollBoss:SetParent(WindowForBosses);
    VScrollBoss:SetOrientation(Turbine.UI.Orientation.Vertical);
    VScrollBoss:SetPosition(ViewPortBoss:GetLeft()+ViewPortBoss:GetWidth(),ViewPortBoss:GetTop());
    VScrollBoss:SetSize(12,ViewPortBoss:GetHeight()); -- set width to 12 since it's a "Lotro" style scrollbar and the height is set to match the control that we will be scrolling
    VScrollBoss:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    VScrollBoss:SetMinimum(0);
    VScrollBoss:SetMaximum(ViewPortBoss.map:GetHeight()-ViewPortBoss:GetHeight()); -- we will allow scrolling the height of the map-the viewport height
    VScrollBoss:SetValue(0); -- set the initial value

    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the map position relative to the viewport
    VScrollBoss.ValueChanged=function()
        ViewPortBoss.map:SetTop(0-VScrollBoss:GetValue());
    end

    --Feeding Data
    for i, parseData in ipairs(dataToShow) do

      -- create the grid of map tiles
      MapTilesBoss={}
      local HIndex;
      for HIndex=1,1 do

        MapTilesBoss[HIndex]={};
        for i, parseData in ipairs(dataToShow) do

            displayText = "Boss: "..parseData[1].."\n".."DPS: "..FormatPerSecondNumber(parseData[2]).."\n".."Time: "..Round(parseData[3], 0).." Seconds".."\n".."Amount: "..FormatNumber(parseData[4]);

            MapTilesBoss[HIndex][i]=Turbine.UI.Label()
            MapTilesBoss[HIndex][i]:SetParent(ViewPortBoss.map);
            MapTilesBoss[HIndex][i]:SetPosition((HIndex-1)*245,(i-1)*88)
            MapTilesBoss[HIndex][i]:SetSize(245,85);
            MapTilesBoss[HIndex][i]:SetForeColor(Turbine.UI.Color.Yellow);
            MapTilesBoss[HIndex][i]:SetFontStyle(Turbine.UI.FontStyle.Outline);
            MapTilesBoss[HIndex][i]:SetFont(Turbine.UI.Lotro.Font.Verdana20);
            MapTilesBoss[HIndex][i]:SetText(displayText);
            MapTilesBoss[HIndex][i]:SetBackColor(Turbine.UI.Color(1, 0.0, 0.0, 0.3));

            --Identify Best Parse
            ShowBestParseOnBoss(parseData[2], displayText);
        end
      end
    end
end

function ShowBestParseOnBoss(NumberValue, TextValue)

    if(tonumber(NumberValue) > BestParseValueOnBoss)then

        BestParseOnBossLabel:SetPosition(10,30);
        BestParseOnBossLabel:SetSize(245,125);
        BestParseOnBossLabel:SetForeColor(Turbine.UI.Color.Yellow);
        BestParseOnBossLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);
        BestParseOnBossLabel:SetFont(Turbine.UI.Lotro.Font.Verdana20);
        BestParseOnBossLabel:SetText("\nThis is your best parse :\n"..TextValue);
        BestParseOnBossLabel:SetBackColor(Turbine.UI.Color.Black);

        BestParseValueOnBoss = tonumber(NumberValue);
    end
end

function OpenWindowBoss()
    WindowForBosses:SetVisible(true);
end

function CloseWindowBoss()
    WindowForBosses:SetVisible(false);
end