------------------------------------------------------------------------------------------
-- Library file
-- Written by Teodoro [Thronur]
------------------------------------------------------------------------------------------

function SetupWindow()

    -- Main Window
    MainWindow = Turbine.UI.Lotro.Window();
    MainWindow:SetPosition(600, 350);
    MainWindow:SetSize(280,400);
    MainWindow:SetText("Parse History");

    BestParseLabel=Turbine.UI.Label()
    BestParseLabel:SetParent(MainWindow);

    -- create a caption for our viewport
    ViewPortCaption=Turbine.UI.Label();
    ViewPortCaption:SetParent(MainWindow);
end

function ShowParses(dataToShow)

    --Cleaning Old ViewPort
    if(ViewPort ~= nil and ViewPort.map ~= nil)then
      ViewPort:SetParent(nil);
      ViewPort.map:SetParent(nil);
    end

    --Reverse order
    dataToShow = ReverseList(dataToShow);

    -- create the viewport control all it needs is size and position as it is simply used to create viewable bounds for our map
    ViewPort=Turbine.UI.Control();
    ViewPort:SetParent(MainWindow);
    ViewPort:SetSize(250,250);
    ViewPort:SetPosition(ViewPortCaption:GetLeft()-40+ViewPortCaption:GetWidth(),ViewPortCaption:GetTop()+125);

    -- create the map content for our viewport, again, it only needs size and position as it is just a container for the grid of images
    ViewPort.map=Turbine.UI.Control();
    ViewPort.map:SetParent(ViewPort); -- set the map as a child of the viewport so that it will be bounded by it for drawing purposes
    ViewPort.map:SetSize(250,table.getn(dataToShow)*48); -- we'll use a 5x4 grid but this obviously could be expanded, or even set up as a recycled array of controls
    ViewPort.map:SetPosition(0,0); -- we'll start off in the upper left

    -- create the vertical scrollbar for our viewport
    VScroll=Turbine.UI.Lotro.ScrollBar();
    VScroll:SetParent(MainWindow);
    VScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    VScroll:SetPosition(ViewPort:GetLeft()+ViewPort:GetWidth(),ViewPort:GetTop());
    VScroll:SetSize(12,ViewPort:GetHeight()); -- set width to 12 since it's a "Lotro" style scrollbar and the height is set to match the control that we will be scrolling
    VScroll:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    VScroll:SetMinimum(0);
    VScroll:SetMaximum(ViewPort.map:GetHeight()-ViewPort:GetHeight()); -- we will allow scrolling the height of the map-the viewport height
    VScroll:SetValue(0); -- set the initial value

    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the map position relative to the viewport
    VScroll.ValueChanged=function()
        ViewPort.map:SetTop(0-VScroll:GetValue());
    end

    --Feeding Data
    for i, parseData in ipairs(dataToShow) do

      -- create the grid of map tiles
      MapTiles={}
      local HIndex;
      for HIndex=1,1 do

        MapTiles[HIndex]={};
        for i, parseData in ipairs(dataToShow) do

            displayText = "DPS: "..FormateNumberForHumans(parseData[1]).."\n".."Date: "..FormateDateForHumans(parseData[2]);

            MapTiles[HIndex][i]=Turbine.UI.Label()
            MapTiles[HIndex][i]:SetParent(ViewPort.map);
            MapTiles[HIndex][i]:SetPosition((HIndex-1)*245,(i-1)*48)
            MapTiles[HIndex][i]:SetSize(245,45);
            MapTiles[HIndex][i]:SetForeColor(Turbine.UI.Color.Yellow);
            MapTiles[HIndex][i]:SetFontStyle(Turbine.UI.FontStyle.Outline);
            MapTiles[HIndex][i]:SetFont(Turbine.UI.Lotro.Font.Verdana20);
            MapTiles[HIndex][i]:SetText(displayText);
            MapTiles[HIndex][i]:SetBackColor(Turbine.UI.Color(1, 0.0, 0.0, 0.3));

            --Identify Best Parse
            ShowBestParse(parseData[1], displayText);
        end
      end
    end
end

function ShowBestParse(NumberValue, TextValue)

    if(tonumber(NumberValue) > BestParseValue)then

        BestParseLabel:SetPosition(10,30);
        BestParseLabel:SetSize(245,85);
        BestParseLabel:SetForeColor(Turbine.UI.Color.Yellow);
        BestParseLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);
        BestParseLabel:SetFont(Turbine.UI.Lotro.Font.Verdana20);
        BestParseLabel:SetText("\nThis is your best parse :\n"..TextValue);
        BestParseLabel:SetBackColor(Turbine.UI.Color.Black);

        BestParseValue = tonumber(NumberValue);
    end
end

function OpenUi()
    MainWindow:SetVisible(true);
end

function CloseUi()
    MainWindow:SetVisible(false);
end