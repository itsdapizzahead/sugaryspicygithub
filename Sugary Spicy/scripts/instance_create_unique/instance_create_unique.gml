function instance_create_unique(argument0, argument1, argument2) //gml_Script_instance_create_unique
{
    if instance_exists(argument2)
        return noone;
    var b = instance_create(argument0, argument1, argument2)
    return b;
}