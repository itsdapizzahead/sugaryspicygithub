function gml_Script_concat() //gml_Script_concat
{
    _string = ""
    for (i = 0; i < argument_count; i++)
        _string += string(argument[i])
    return _string;
}
function concat() //gml_Script_concat
{
    _string = ""
    for (i = 0; i < argument_count; i++)
        _string += string(argument[i])
    return _string;
}