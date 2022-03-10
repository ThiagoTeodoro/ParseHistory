------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

function SetupWindowForDummyParse()

    -- Main Window
    WindowForDummys = Turbine.UI.Lotro.Window();
    WindowForDummys:SetPosition(600, 350);
    WindowForDummys:SetSize(280,400);
    WindowForDummys:SetText("Parse History");

    BestParseOnDummyLabel=Turbine.UI.Label()
    BestParseOnDummyLabel:SetParent(WindowForDummys);

    -- create a caption for our viewport
    ViewPortCaptionDummy=Turbine.UI.Label();
    ViewPortCaptionDummy:SetParent(WindowForDummys);
end

function ShowDummyParses(dataToShow)

    --Cleaning Old ViewPort
    if(ViewPortDummy ~= nil and ViewPortDummy.map ~= nil) then
      ViewPortDummy:SetParent(nil);
      ViewPortDummy.map:SetParent(nil);
    end

    --Reverse order
    dataToShow = ReverseList(dataToShow);

    -- create the viewport control all it needs is size and position as it is simply used to create viewable bounds for our map
    ViewPortDummy=Turbine.UI.Control();
    ViewPortDummy:SetParent(WindowForDummys);
    ViewPortDummy:SetSize(250,250);
    ViewPortDummy:SetPosition(ViewPortCaptionDummy:GetLeft()-40+ViewPortCaptionDummy:GetWidth(),ViewPortCaptionDummy:GetTop()+125);

    -- create the map content for our viewport, again, it only needs size and position as it is just a container for the grid of images
    ViewPortDummy.map=Turbine.UI.Control();
    ViewPortDummy.map:SetParent(ViewPortDummy); -- set the map as a child of the viewport so that it will be bounded by it for drawing purposes
    ViewPortDummy.map:SetSize(250,table.getn(dataToShow)*48); -- we'll use a 5x4 grid but this obviously could be expanded, or even set up as a recycled array of controls
    ViewPortDummy.map:SetPosition(0,0); -- we'll start off in the upper left

    -- create the vertical scrollbar for our viewport
    VScrollDummy=Turbine.UI.Lotro.ScrollBar();
    VScrollDummy:SetParent(WindowForDummys);
    VScrollDummy:SetOrientation(Turbine.UI.Orientation.Vertical);
    VScrollDummy:SetPosition(ViewPortDummy:GetLeft()+ViewPortDummy:GetWidth(),ViewPortDummy:GetTop());
    VScrollDummy:SetSize(12,ViewPortDummy:GetHeight()); -- set width to 12 since it's a "Lotro" style scrollbar and the height is set to match the control that we will be scrolling
    VScrollDummy:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    VScrollDummy:SetMinimum(0);
    VScrollDummy:SetMaximum(ViewPortDummy.map:GetHeight()-ViewPortDummy:GetHeight()); -- we will allow scrolling the height of the map-the viewport height
    VScrollDummy:SetValue(0); -- set the initial value

    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the map position relative to the viewport
    VScrollDummy.ValueChanged=function()
        ViewPortDummy.map:SetTop(0-VScrollDummy:GetValue());
    end

    --Feeding Data
    for i, parseData in ipairs(dataToShow) do

      -- create the grid of map tiles
      MapTilesDummy={}
      local HIndex;
      for HIndex=1,1 do

        MapTilesDummy[HIndex]={};
        for i, parseData in ipairs(dataToShow) do

            displayText = "DPS: "..FormateNumberForHumans(parseData[1]).."\n".."Date: "..FormateDateForHumans(parseData[2]);

            MapTilesDummy[HIndex][i]=Turbine.UI.Label()
            MapTilesDummy[HIndex][i]:SetParent(ViewPortDummy.map);
            MapTilesDummy[HIndex][i]:SetPosition((HIndex-1)*245,(i-1)*48)
            MapTilesDummy[HIndex][i]:SetSize(245,45);
            MapTilesDummy[HIndex][i]:SetForeColor(Turbine.UI.Color.Yellow);
            MapTilesDummy[HIndex][i]:SetFontStyle(Turbine.UI.FontStyle.Outline);
            MapTilesDummy[HIndex][i]:SetFont(Turbine.UI.Lotro.Font.Verdana20);
            MapTilesDummy[HIndex][i]:SetText(displayText);
            MapTilesDummy[HIndex][i]:SetBackColor(Turbine.UI.Color(1, 0.0, 0.0, 0.3));

            --Identify Best Parse
            ShowBestParseOnDummy(parseData[1], displayText);
        end
      end
    end
end

function ShowBestParseOnDummy(NumberValue, TextValue)

    if(tonumber(NumberValue) > BestParseValueOnDummy)then

        BestParseOnDummyLabel:SetPosition(10,30);
        BestParseOnDummyLabel:SetSize(245,85);
        BestParseOnDummyLabel:SetForeColor(Turbine.UI.Color.Yellow);
        BestParseOnDummyLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);
        BestParseOnDummyLabel:SetFont(Turbine.UI.Lotro.Font.Verdana20);
        BestParseOnDummyLabel:SetText("\nThis is your best parse :\n"..TextValue);
        BestParseOnDummyLabel:SetBackColor(Turbine.UI.Color.Black);

        BestParseValueOnDummy = tonumber(NumberValue);
    end
end

function OpenWindowDummy()
    WindowForDummys:SetVisible(true);
end

function CloseWindowDummy()
    WindowForDummys:SetVisible(false);
end