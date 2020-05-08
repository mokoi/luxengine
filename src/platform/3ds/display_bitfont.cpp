#include "display_bitfont.h"
#include "bitfont.h"
#include "core.h"

/**
 * @brief DisplayFont::DisplayFont
 */
DisplayBitFont::DisplayBitFont( )
{
	uint8_t * font_point = &gfxPrimitivesFontdata[0];
	uint8_t l = 0, q;
	uint32_t * charflip = new uint32_t[64];
	for ( uint8_t c = 0; c < 130; c++)
	{

		//uint16_t * charflip = new uint16_t[64];
		for (l = 0; l < 8; l++)
		{
			for (q = 0; q < 8; q++)
			{
				uint8_t y = (l)*8;
				charflip[y + (7-q)] = !!(font_point[l] & (1 << q)) ? 0xFFFFFFFF : 0x00000000 ;
			}
		}
		C3D_TexInit(this->textures[c], 8, 8, GPU_TEXCOLOR::GPU_RGBA8 );
		C3D_TexUpload(this->textures[c], charflip);
		font_point += 8;


	}
	delete[] charflip;
}


/**
 * @brief DisplayFont::~DisplayFont
 */
DisplayBitFont::~DisplayBitFont()
{
	for ( uint8_t c = 0; c < 130; c++)
	{
		C3D_TexDelete(this->textures[c]);
	}
}

/**
 * @brief DisplayFont::GetTexture
 * @param character
 * @return
 */
C3D_Tex *DisplayBitFont::GetTexture(uint32_t character)
{

	C3D_Tex * texture = NULL;
	if ( character >= 32 && character <= 128 )
	{
		texture = this->textures[character];
	}
	else if ( character  == 0x2026 )//…
	{
		texture = this->textures[129];
	}
	else // �
	{
		texture = this->textures[128];
	}
	return texture;
}
