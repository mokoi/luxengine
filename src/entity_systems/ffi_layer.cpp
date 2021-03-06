/****************************
Copyright © 2014 Luke Salisbury
This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
****************************/

#include "ffi_layer.h"
#include "ffi_functions.h"

#include "display/display.h"
#include "elix/elix_endian.hpp"

/**
 * @brief Lux_FFI_Layer_Rotation
 * @param layer
 * @param roll
 * @param pitch
 * @param yaw
 */
void Lux_FFI_Layer_Rotation( int8_t layer, int16_t roll, int16_t pitch, int16_t yaw )
{
	lux::display->ChangeLayerRotation( layer, roll, pitch, yaw );
}

/**
 * @brief Lux_FFI_Layer_Offset
 * @param layer
 * @param x
 * @param y
 */
void Lux_FFI_Layer_Offset( int8_t layer, int32_t fixed_x, int32_t fixed_y )
{
	if ( layer == -1)
		lux::display->SetCameraView( (fixed)fixed_x, (fixed)fixed_y );
	else
		lux::display->SetCameraView( layer, (fixed)fixed_x, (fixed)fixed_y );
}

/**
 * @brief Lux_FFI_Layer_Colour
 * @param layer
 * @param colour
 */
void Lux_FFI_Layer_Colour( int8_t layer, uint32_t colour)
{
	cell_colour temp_colour;
	temp_colour.hex = elix::endian::host32( colour );
	if ( layer >= 0 )
		lux::display->SetLayerColour( layer, temp_colour.rgba );
}
