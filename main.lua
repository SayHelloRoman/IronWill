widget = require( "widget" )
json = require( "json" )
math = require( "math" )
db = require( "db" )

database = db:new()
json = database:getJson()
text_button = "Запустить"
time_text = "0 дней"

if(not ( json == nil )) then
    if(not(json["start"] == 0)) then
        i = math.floor((os.time() - json["start"]) / 86400)
        text_button = "Остановить"
        if (not(i == 0)) then
            time_text = i .. " день"
        end
    end
end

function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        if (create_stop_button:getLabel() == "Запустить") then
            create_stop_button:setLabel("Остановить")
            t = {}; t.start = os.time();
            database:writeJson( t )

        elseif (create_stop_button:getLabel() == "Остановить") then
            create_stop_button:setLabel("Запустить")
            time_label.text = "0 дней"
            t = {}; t.start = 0;
            database:writeJson( t )
        end

    end
end

display.setDefault( "background", 0, 0.11, 0.22 )
create_stop_button = widget.newButton( {
    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
    fontSize = 25,
    width = 150,
    height = 80,
    label = text_button,
    defaultFile = "кнопка.png",
    onEvent = handleButtonEvent
} )

create_stop_button.x = display.contentCenterX
create_stop_button.y = display.contentCenterY + 200

time_label = display.newText( time_text, 100, 200, native.systemFont, 38 )
time_label:setFillColor( 1, 1, 1 )
time_label.x = display.contentCenterX
time_label.y = 0