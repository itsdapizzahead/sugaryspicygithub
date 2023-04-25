// @description Shows hidden tiles when the player touches this trigger

function removeTiles() {
	array_push(global.dslist, self.id)
	instance_destroy(self)
	if !global.tileset exit; // no tileset? then stop the function here
	var tilemap = layer_tilemap_get_id(global.tileset)
	var ix = 0
	var iy = 0
	while iy < image_yscale {
		ix = 0
		while ix < image_xscale {
			tilemap_set_at_pixel(tilemap, tile_set_empty(tilemap), x + (ix * 32), y + (iy * 32))
			ix++
		}
		iy++
	}
}
/*
alpha = 1
depth = -8
tiles[0] = array_create(0)
tiles[1] = array_create(0)
tiles[2] = array_create(0)
for (var i = 0; i < 3; i++)
{
	var lay_id = layer_get_id(concat("Tiles_Secret", (i + 1)))
	tilemap_sprite[i] = -4
	if (lay_id != -1)
	{
		var map_id = layer_tilemap_get_id(lay_id)
		var t = -4

		tilemap_sprite[i] = t
		var _w32 = (sprite_get_width(t) / 32)
		for (var yy = 0; yy < image_yscale; yy++)
		{
			for (var xx = 0; xx < image_xscale; xx++)
			{
				var _x = (x + (xx * 32))
				var _y = (y + (yy * 32))
				var data = tilemap_get_at_pixel(map_id, _x, _y)
				var _id = tile_get_index(data)
				var xi = 0
				var yi = 0
				for (var j = 0; j < _id; j++)
				{
					xi++
					if (xi >= _w32)
					{
						xi = 0
						yi++
					}
				}
				array_push(tiles[i], [_x, _y, (xi * 32), (yi * 32)])
				data = tile_set_empty(data)
				tilemap_set_at_pixel(map_id, data, _x, _y)
			}
		}
	}
}
trace(tilemap_sprite)
if (array_length(tiles[0]) <= 0 && array_length(tiles[1]) <= 0 && array_length(tiles[2]) <= 0)
	instance_destroy()
*/