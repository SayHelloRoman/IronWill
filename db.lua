system = require( "system" )
json = require( "json" )
io = require( "io" )

DataBase = {}

function DataBase:new()

    local obj = {}
    obj.json = require( "json" )
    obj.file = file

    function obj:getJson()
        path = system.pathForFile( "data.json", system.DocumentsDirectory )
        file = io.open( path, "a+" )
        io.input(file)
        content = io.read("*a")
        io.close(file)

        return json.decode( content )
    end

    function obj:writeJson(table)
        path = system.pathForFile( "data.json", system.DocumentsDirectory )
        file = io.open( path, "w+" )
        io.output( file )
        io.write( self.json.encode( table ) )
        io.close( file )
    end

    setmetatable( obj, self )
    self.__index = self; return obj

end

return DataBase